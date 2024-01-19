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

# Start starship
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
