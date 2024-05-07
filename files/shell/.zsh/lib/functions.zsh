#!/bin/zsh

cdu() {
  local LOCATION=""

  for i in {1..${1:=1}}
  do
    LOCATION+="../"
  done

  cd $LOCATION
}

fzf-directory() {
  # --height 99% - to make sure the terminal will use the 'insert mode cursor'
  local DIRECTORY=$(fd . ${1:=.} --type d --hidden --exclude '.git' | fzf --height 99% --layout reverse --preview 'tree -F -I "node_modules|target|dist" -L 2 {}');

  # 'return' the directory
  echo $DIRECTORY
}

cduf() {
  local LOCATION=""

  for i in {1..${1:=1}}
  do
    LOCATION+="../"
  done

  local DIRECTORY=$(fzf-directory $LOCATION)

  # if $DIRECTORY is NOT an empty string
  if [[ -n "${DIRECTORY}" ]]; then
    cd $DIRECTORY
  else
    cd $LOCATION
  fi

}

fzf-home-widget() {
  local DIRECTORY=$(fzf-directory $HOME)

  # if $DIRECTORY is NOT an empty string
  if [[ -n "${DIRECTORY}" ]]; then
    cd $DIRECTORY
  fi

  zle clear-screen
  zle reset-prompt
}

fzf-cwd-widget() {
  local DIRECTORY=$(fzf-directory $(pwd))

  # if $DIRECTORY is NOT an empty string
  if [[ -n "${DIRECTORY}" ]]; then
    cd $DIRECTORY
  fi

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
  local SESSION_NAME=$(tmux ls | fzf | rg -o "^\w+");

  # if $SESSION_NAME is not an empty string
  if [[ -n "${SESSION_NAME}" ]]; then
    # if $TMUX is an empty string
    if [[ -z "$TMUX"  ]]; then
        tmux a -t $SESSION_NAME;
    else
      # if $SESSION_NAME is not an empty string
      if [[ -n "${SESSION_NAME}" ]]; then
        tmux switch-client -t $SESSION_NAME
      fi
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

clear-screen-widget() {
  zle clear-screen

  if [[ -n "$TMUX" ]]; then
    tmux clear-history
  fi

  if [[ -n "$ZELLIJ" ]]; then
    zellij action clear

    zle reset-prompt
    zle zle-keymap-select
  fi
}

# load dependencies for git hooks if there are any
git-hooks-lazygit() {
  eval "$(mise activate zsh)"
  eval "$(mise hook-env)"

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

# git related functions
# list worktree then cd
gwf() {
  local directory=$(git worktree list | fzf --height 50% --layout reverse | awk '{print $1}')
  if [[ -n "${directory}" ]]; then
    cd $directory
  fi
}

# workaround to allow the use of zle reset-prompt
gwf-widget() {
  gwf
  zle reset-prompt
}

# https://gist.github.com/reegnz/b9e40993d410b75c2d866441add2cb55
jqi() {
  local input=$1

  if [[ -z $1 ]] || [[ $1 == "-" ]]; then
    input=$(mktemp)
    trap "rm -f $input" EXIT
    cat /dev/stdin >$input
  fi

  echo '' |
    fzf --disabled \
      --preview-window='up:90%' \
      --print-query \
      --preview "jq --color-output {q} $input"
}
