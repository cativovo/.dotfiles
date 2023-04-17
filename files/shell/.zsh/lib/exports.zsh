#!/bin/zsh

# Export here
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# SET VIM AS DEFAULT EDITOR
export VISUAL="nvim"
export EDITOR="$VISUAL"

export PATH="$PATH:/Users/markleocativo/.local/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# change default config path of starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# change default config path of lazygit
export XDG_CONFIG_HOME="$HOME/.config"
