#!/bin/zsh

cdu() {
  local LOCATION=""

  for i in {1..${1:=1}}
  do
    LOCATION+="../"
  done

  cd $LOCATION
}

cdf() {
  local DIRECTORY=$(fd . ${1:=.} --type d --hidden --exclude '.git' | fzf);

    # if $DIRECTORY is an empty string
  if [[ -z "${DIRECTORY}" ]]; then
    DIRECTORY=${1:=.}
  fi

  cd $DIRECTORY;
}

cduf() {
  local LOCATION=""

  for i in {1..${1:=1}}
  do
    LOCATION+="../"
  done

  cdf $LOCATION
}

fzf-directory() {
  cdf
  zle reset-prompt;
}

fzf-tmux-new-session() {
  local DIRECTORY=$(fd . ~ --type d --hidden --exclude '.git' | fzf);

  # if $DIRECTORY is not an empty string
  if [[ -n "${DIRECTORY}" ]]; then
    local SESSION_NAME=$1;

    # if $SESSION_NAME is an empty string
    if [[ -z "${SESSION_NAME}" ]]; then
      # get base directory and remove the dots(.)
      SESSION_NAME=$(basename $DIRECTORY | tr -d '.');
    fi

    # if $TMUX is an empty string
    if [[ -z "$TMUX"  ]]; then
      # create new session (outside of a session)
      tmux new -s $SESSION_NAME -c $DIRECTORY
    else
      # create new session (inside of a session in detach mode) then switch to that session
      tmux new -s $SESSION_NAME -c $DIRECTORY -d
      tmux switch-client -t $SESSION_NAME
    fi
  fi
}

fzf-tmux-attach() {
  # if $TMUX is an empty string
  if [[ -z "$TMUX"  ]]; then
    local SESSION_NAME=$(tmux ls | fzf | rg -o "^\w+");

    # if $SESSION_NAME is not an empty string
    if [[ -n "${SESSION_NAME}" ]]; then
      tmux a -t $SESSION_NAME;
    fi
  fi
}

# nvm helpers
find-nvmrc() {
  # find .nvmrc
  # https://github.com/nvm-sh/nvm/blob/master/nvm.sh#L428
  # https://github.com/nvm-sh/nvm/blob/master/nvm.sh#L437
  local dir
  local path_
  path_="${PWD}"

  while [ "${path_}" != "" ] && [ "${path_}" != '.' ] && [ ! -f "${path_}/.nvmrc" ]; do
    path_=${path_%/*}
  done

  dir="${path_}"

  if [ -e "${dir}/.nvmrc" ]; then
    echo "${dir}/.nvmrc"
  fi
}

# lazy load nvm
load-nvm() {
   unset -f nvm node yarn npm load-nvm
   echo "Loading nvm...";
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";  # This loads nvm
   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion";  # This loads nvm bash_completion
}

nvm() {
    load-nvm
    nvm $@
}

node() {
    load-nvm
    node $@
}

npm() {
    load-nvm
    npm $@
}

yarn() {
    load-nvm
    yarn $@
}

show-my-zsh-functions() {
  rg '.*\(\)' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/functions.zsh
}

show-my-zsh-aliases() {
  rg 'alias .*' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/aliases.zsh
}

show-my-zsh-keymaps() {
  rg 'bindkey .*' -N -o $HOME/.dotfiles/files/shell/.zsh/lib/keymaps.zsh
}

clear-screen-and-tmux-history() {
  zle clear-screen

  if [[ -n "$TMUX" ]]; then
    tmux clear-history
  fi
}

# load dependencies for git hooks if there are any
git-hooks-lazygit() {
  # load nvm if there's husky
  if [[ -d ".husky" ]]; then
    load-nvm
  fi

  lazygit
}
