# LOAD EXPORTS
source $HOME/.zsh/lib/exports.zsh

# LOAD ALIASES
source $HOME/.zsh/lib/aliases.zsh

# LOAD CUSTOM FUNCTIONS
source $HOME/.zsh/lib/functions.zsh

# LOAD OPTIONS
source $HOME/.zsh/lib/options.zsh

# LOAD HOOKS
source $HOME/.zsh/lib/hooks.zsh

# LOAD PLUGINS
source $HOME/.zsh/lib/plugins.zsh

# Start starship
eval "$(starship init zsh)"
