#!/bin/zsh

# SET VIM AS DEFAULT EDITOR
export VISUAL="nvim"
export EDITOR="$VISUAL"

# change default config path of starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# for vi mode
export KEYTIMEOUT=1

# change lazygit config directory
export XDG_CONFIG_HOME="$HOME/.config"

local private_env="$HOME/.private_env"
if [ -f $private_env ]; then
	source $private_env
fi
