#!/bin/zsh

cdu() {
  local LOCATION=""

  for i in {1..${1:=1}}
  do
    LOCATION+="../"
  done

  cd $LOCATION
}

cdf() {
  # --height 99% - to make sure the terminal will use the 'insert mode cursor'
  local DIRECTORY=$(fd . ${1:=.} --type d --hidden --exclude '.git' | fzf --height 99% --layout reverse);

    # if $DIRECTORY is an empty string
  if [[ -z "${DIRECTORY}" ]]; then
    DIRECTORY=${1:=.}
  fi

  cd $DIRECTORY;
}

cduf() {
  local LOCATION=""

  for i in {1..${1:=1}}
  do
    LOCATION+="../"
  done

  cdf $LOCATION
}

fzf-directory() {
  cdf ~
  zle clear-screen
  zle reset-prompt
}

fzf-tmux-new-session() {
  local DIRECTORY=$(fd . ~ --type d --hidden --exclude '.git' | fzf);

  # if $DIRECTORY is not an empty string
  if [[ -n "${DIRECTORY}" ]]; then
    local SESSION_NAME=$1;

    # if $SESSION_NAME is an empty string
    if [[ -z "${SESSION_NAME}" ]]; then
      # get base directory and remove the dots(.)
      SESSION_NAME=$(basename $DIRECTORY | tr -d '.');
    fi

    # if $TMUX is an empty string
    if [[ -z "$TMUX"  ]]; then
      # create new session (outside of a session)
      tmux new -s $SESSION_NAME -c $DIRECTORY
    else
      # create new session (inside of a session in detach mode) then switch to that session
      tmux new -s $SESSION_NAME -c $DIRECTORY -d
      tmux switch-client -t $SESSION_NAME
    fi
  fi
}

fzf-tmux-attach() {
  # if $TMUX is an empty string
  if [[ -z "$TMUX"  ]]; then
    local SESSION_NAME=$(tmux ls | fzf | rg -o "^\w+");

    # if $SESSION_NAME is not an empty string
    if [[ -n "${SESSION_NAME}" ]]; then
      tmux a -t $SESSION_NAME;
    fi
  fi
}

# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh#L98
fzf-history-widget() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null

  local selected num

  selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="--height 50% --layout reverse  -n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore --query=${(qqq)LBUFFER} +m" "fzf") )

  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

show-my-zsh-functions() {
  rg '.*\(\)' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/functions.zsh
}

show-my-zsh-aliases() {
  rg 'alias .*' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/aliases.zsh
}

show-my-zsh-keymaps() {
  rg 'bindkey .*' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/keymaps.zsh
}

my-clear-screen() {
  if [[ -n "$TMUX" ]]; then
    tmux clear-history
  fi

  if [[ -n "$ZELLIJ" ]]; then
    zellij action clear
  fi

  zle clear-screen
  zle reset-prompt
  zle zle-keymap-select
}

# load dependencies for git hooks if there are any
git-hooks-lazygit() {
  eval "$(rtx activate zsh)"
  eval "$(rtx hook-env)"

  lazygit
}

# zellij related functions
# create new session
zn() {
  # this can be used inside of session
  ZELLIJ_SESSION_CWD=$1
  local directory_basename=$(basename $ZELLIJ_SESSION_CWD | tr -d '.')
  local session_name=${2:-$directory_basename}
  local layout=${3:-default}

  zellij -s $session_name -l $layout options --default-cwd $ZELLIJ_SESSION_CWD
}

# find directory using fd and fzf then use that to create a new session
zf() {
  local directory=$(fd . ~ --type d --hidden --exclude '.git' | fzf --height 50% --layout reverse);

  local layout=""

  while getopts ":l:" opt; do
    case "$opt" in
      l)
        layout="$OPTARG"  # Store the string argument after -l
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        ;;
    esac
  done

  # Shift to remove the processed options from the argument list
  shift $((OPTIND - 1))
  
  # if $directory is not an empty string
  if [[ -n "${directory}" ]]; then
    zn $directory "$1" $layout
  fi
}

# list session then attach to it
zs() {
  local SESSION_NAME=$(zellij ls -n | fzf --height 50% --layout reverse | rg -o '^[^ ]+');

  # if $SESSION_NAME is not an empty string
  if [[ -n "${SESSION_NAME}" ]]; then
    zellij a $SESSION_NAME $1
  fi
}
