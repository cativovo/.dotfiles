#!/bin/zsh

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

zle -N fzf-directory
bindkey '^p' fzf-directory

# workaround to call fzf-tmux-new-session function
bindkey -s "^t" 'tfn\n'
# workaround to call fzf-tmux-attach function
bindkey -s "^a" 'tfa\n'

# https://github.com/spaceship-prompt/spaceship-prompt/issues/91#issuecomment-327996599
bindkey "^?" backward-delete-char

bindkey -M menuselect '^[[Z' reverse-menu-complete

zle -N clear-screen-and-tmux-history
bindkey "^l" clear-screen-and-tmux-history

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
