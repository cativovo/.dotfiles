#!/bin/zsh

local TPM_DIRECTORY="$HOME/.tmux/plugins/tpm"
[[ ! -d "$TPM_DIRECTORY" ]] && {
  echo "Installing tpm..."

  git clone https://github.com/tmux-plugins/tpm $TPM_DIRECTORY
}
