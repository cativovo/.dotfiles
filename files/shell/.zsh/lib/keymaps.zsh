#!/bin/zsh

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

zle -N fzf-directory-widget
bindkey '^p' fzf-directory-widget

zle -N fzf-history-widget
bindkey '^r' fzf-history-widget

# workaround to call fzf-tmux-new-session function
# bindkey -s "^t" 'tfn\n'
# workaround to call fzf-tmux-attach function
# bindkey -s "^a" 'tfa\n'

# https://github.com/spaceship-prompt/spaceship-prompt/issues/91#issuecomment-327996599
bindkey "^?" backward-delete-char

bindkey -M menuselect '^[[Z' reverse-menu-complete

zle -N my-clear-screen
bindkey "^l" my-clear-screen

# https://github.com/zsh-users/zsh-history-substring-search#usage
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# git related keymaps
zle -N gwf-widget
bindkey '^w' gwf-widget
