#!/bin/zsh

# Export here
export NVM_DIR="$HOME/.nvm"

# SET VIM AS DEFAULT EDITOR
export VISUAL="nvim"
export EDITOR="$VISUAL"

# add something here if needed
export PATH="$PATH:$HOME/.mvn/bin"

# change default config path of starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# for vi mode
export KEYTIMEOUT=1

# change lazygit config directory
export XDG_CONFIG_HOME="$HOME/.config"
