#!/bin/zsh

# LOAD PLUGINS
local ZAP_DIR="$HOME/.local/share/zap"

 # check if zap is installed
 [[ ! -d "$ZAP_DIR" ]] && {
   echo "Installing zap..."

  # install zap
  git clone -b "${BRANCH:-master}" https://github.com/zap-zsh/zap.git "$ZAP_DIR" > /dev/null 2>&1 || { echo "❌ Failed to install Zap" && return 2 }

  echo " Zapped"
  echo "Find more plugins at http://zapzsh.org"

  exec zsh || return
}

source $HOME/.local/share/zap/zap.zsh

# plugin list
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
