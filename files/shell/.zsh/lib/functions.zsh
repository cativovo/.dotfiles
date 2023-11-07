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
  local DIRECTORY=$(fd . ${1:=.} --type d --hidden --exclude '.git' | fzf);

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
  cdf
  zle reset-prompt;
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

show-my-zsh-functions() {
  rg '.*\(\)' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/functions.zsh
}

show-my-zsh-aliases() {
  rg 'alias .*' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/aliases.zsh
}

show-my-zsh-keymaps() {
  rg 'bindkey .*' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/keymaps.zsh
}

clear-screen-and-tmux-history() {
  zle clear-screen

  if [[ -n "$TMUX" ]]; then
    tmux clear-history
  fi
}

# load dependencies for git hooks if there are any
git-hooks-lazygit() {
  eval "$(rtx activate zsh)"
  eval "$(rtx hook-env)"

  lazygit
}

open-notes() {
  cd ~/notes
  nvim -c "lua require('plugins.neorg').open_workspace()"
}

# zellij related functions
# create new session
zn() {
  # this can be used inside of session
  ZELLIJ_SESSION_CWD=$1
  local DIRECTORY_BASENAME=$(basename $ZELLIJ_SESSION_CWD | tr -d '.')
  local SESSION_NAME=${2:-$DIRECTORY_BASENAME}

  zellij -s $SESSION_NAME options --default-cwd $ZELLIJ_SESSION_CWD
}

# find directory using fd and fzf then use that to create a new session
zf() {
  local DIRECTORY=$(fd . ~ --type d --hidden --exclude '.git' | fzf);

  # if $DIRECTORY is not an empty string
  if [[ -n "${DIRECTORY}" ]]; then
    zn $DIRECTORY $1
  fi
}

# list session then attach to it
zs() {
  local SESSION_NAME=$(zellij ls | fzf);

  # if $SESSION_NAME is not an empty string
  if [[ -n "${SESSION_NAME}" ]]; then
    zellij a $SESSION_NAME $1
  fi
}
