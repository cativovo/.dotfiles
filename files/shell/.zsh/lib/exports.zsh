#!/bin/zsh

# SET VIM AS DEFAULT EDITOR
export VISUAL="nvim"
export EDITOR="$VISUAL"

# add something here if needed
export PATH="$PATH:$HOME/.atuin/bin"

# change default config path of starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# for vi mode
export KEYTIMEOUT=1

# change lazygit config directory
export XDG_CONFIG_HOME="$HOME/.config"

export FZF_DEFAULT_OPTS="--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"

local private_env="$HOME/.private_env"
if [ -f $private_env ]; then
	source $private_env
fi
