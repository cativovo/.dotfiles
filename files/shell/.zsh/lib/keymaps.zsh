#!/bin/zsh

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

zle -N fzf-directory
bindkey '^o' fzf-directory

# workaround to call fzf-tmux-new-session function
bindkey -s "^t" 'tfn\n'
# workaround to call fzf-tmux-attach function
bindkey -s "^a" 'tfa\n'

# https://github.com/spaceship-prompt/spaceship-prompt/issues/91#issuecomment-327996599
bindkey "^?" backward-delete-char
