#!/bin/zsh

cdx() {
  if cd "$1"; then 
    exa -a;
  fi
}

fzf-directory() {
  local DIRECTORY=$(fd . --type d --hidden --exclude '.git' | fzf);

    # if $DIRECTORY is not an empty string
    if [[ -n "${DIRECTORY}" ]]; then
      cd $DIRECTORY;
      zle reset-prompt;
    fi
}

fzf-tmux-new-session() {
  local DIRECTORY=$(fd . ~ --type d --hidden --exclude '.git' | fzf);

  # if $DIRECTORY is not an empty string
  if [[ -n "${DIRECTORY}" ]]; then
    local SESSION_NAME=$1;

    # if $SESSION_NAME is an empty string
    if [[ -z "${SESSION_NAME}" ]]; then
      SESSION_NAME=$(basename $DIRECTORY);
    fi

    tmux new -s $SESSION_NAME -c $DIRECTORY
  fi
}

fzf-tmux-attach() {
  local SESSION_NAME=$(tmux ls | fzf | rg -o "^\w+");

  # if $SESSION_NAME is not an empty string
  if [[ -n "${SESSION_NAME}" ]]; then
    tmux a -t $SESSION_NAME;
  fi
}
