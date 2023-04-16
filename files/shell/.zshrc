# LOAD EXPORTS
source $HOME/.exports

# LOAD ALIASES
source $HOME/.aliases

# LOAD CUSTOM FUNCTIONS
source $HOME/.functions

# LOAD PLUGINS
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#manual-git-clone
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


# Functions

# https://github.com/nvm-sh/nvm#zsh
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

set -o vi
setopt noincappendhistory
setopt nosharehistory
unsetopt BEEP

# autocompletion 
source ~/.zsh/lib/completion.zsh

# Start starship
eval "$(starship init zsh)"
