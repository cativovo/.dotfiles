#!/bin/zsh

cdx() {
  if cd "$1"; then 
    exa -a;
  fi
}

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
