# LOAD PLUGINS
source $HOME/.zsh/lib/plugins.zsh

# LOAD ALIASES
source $HOME/.zsh/lib/aliases.zsh

# LOAD OPTIONS
source $HOME/.zsh/lib/options.zsh

# LOAD HOOKS
source $HOME/.zsh/lib/hooks.zsh

# LOAD KEYMAPS
source $HOME/.zsh/lib/keymaps.zsh

# AUTO INSTALL SOME OF DEPENDENCIES
source $HOME/.zsh/lib/auto_install_dependencies.zsh


# https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#execute-extra-commands
function init() {
	eval "$(starship init zsh)"
	eval "$(mise activate zsh)"
	eval "$(atuin init zsh --disable-up-arrow)"
	keymap_init
}

zvm_after_init_commands+=(init)
