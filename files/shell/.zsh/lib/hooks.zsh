#!/bin/zsh

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

load-nvm() {
   echo "Loading nvm...";
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";  # This loads nvm
   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion";  # This loads nvm bash_completion
}

nvm() {
    unset -f nvm
    load-nvm
    nvm "$@"
}

# https://github.com/nvm-sh/nvm#zsh
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(find-nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD find-nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# vi mode config
# Change cursor shape for different vi modes.
zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
