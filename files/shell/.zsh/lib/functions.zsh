#!/bin/zsh

cdx() {
  if cd "$1"; then 
    exa -a;
  fi
}

fzf-directory() {
  local DIRECTORIES=$(fd . --type d --hidden --exclude '.git' | fzf)

  if [[ -n "${DIRECTORIES}" ]]; then
    cd $DIRECTORIES
     zle reset-prompt
  fi
}
