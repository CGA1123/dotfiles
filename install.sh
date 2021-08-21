#!/usr/bin/env bash

set -euo pipefail

RUBY_VERSION="2.7.2"
NODE_VERSION="14.17.0"

# is_dev_environment checks whether the current box is a throwaway dev
# environment, such as a codespace.
function is_dev_environment() {
  ([[ "$(logname)" == "build" ]] || [[ ! -z ${CODESPACES} ]]) && [[ -z "${DOTFILES_FULL_INSTALL}" ]]
}

# fstow will forcible run stow, moving any conflicting files/folders by
# renaming them with a `.bak` suffix
#
function fstow() {
  local SRC="${1}"
  local DST="${2}"

  POTENTIAL_FILES=$(ls -1a ${SRC} | grep -v "^\.\.\?$")
  for POTENTIAL_FILE in ${POTENTIAL_FILES}; do
    local POTENTIAL_PATH="${DST}/${POTENTIAL_FILE}"

    if [[ -d "${POTENTIAL_PATH}" ]] || [[ -f "${POTENTIAL_PATH}" ]]; then
      echo "moving ${POTENTIAL_PATH}"
      mv "${POTENTIAL_PATH}" "${POTENTIAL_PATH}.bak"
    fi
  done

  stow ${SRC} --target ${DST}
}

function brew_installed() {
  local KERNEL=$(uname -s)
  local ARCH=$(uname -p)

  case "${KERNEL}-${ARCH}" in
    Darwin-arm)
      test -d /opt/homebrew
      ;;
    Darwin-i386)
      test -d /usr/local/Homebrew
      ;;
    Linux-*)
      test -d ~/.linuxbrew || test -d /home/linuxbrew/.linuxbrew
      ;;
  esac
}

function brew_dir() {
  local KERNEL=$(uname -s)
  local ARCH=$(uname -p)

  case "${KERNEL}-${ARCH}" in
    Darwin-arm)
      echo "/opt/homebrew"
      ;;
    Darwin-i386)
      echo "/usr/local/Homebrew"
      ;;
    Linux-*)
      (test -d ~/.linuxbrew && echo "~/.linuxbrew") || (test -d /home/linuxbrew/.linuxbrew && echo "/home/linuxbrew/.linuxbrew")
      ;;
  esac
}

function asdf_plugin_install () {
  local plugin=${1}

  if ! $(asdf plugin list | grep -q "${plugin}"); then
    asdf plugin add "${plugin}"
  fi
}

# initialize submodules
git submodule update --init --recursive

# make sure some dirs exist
mkdir -p ${HOME}/tmp

if [[ ! is_dev_environment ]]; then
  # install homebrew, if it isn't already
  brew_installed > /dev/null 2>&1 || /bin/bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"

  # install Brewfile
  eval "$(brew_dir)/bin/brew bundle --verbose"

  asdf_plugin_install "ruby"
  asdf_plugin_install "nodejs"

  asdf install ruby "${RUBY_VERSION}"
  asdf global ruby "${RUBY_VERSION}"

  asdf install nodejs "${NODE_VERSION}"
  asdf global nodejs "${NODE_VERSION}"
else
  sudo apt-get update
  sudo apt-get install -y \
    vim \
    silversearcher-ag \
    stow \
    ripgrep \
    exuberant-ctags

  sudo /bin/bash -c 'curl -sfLS install-node.vercel.app/lts | bash -s -- --yes'
fi

# setup dotfiles
fstow bash "${HOME}"
fstow git "${HOME}"
fstow rspec "${HOME}"
fstow tmux "${HOME}"
fstow vim "${HOME}"

if [[ ! -s ${CODESPACES} ]]; then
  git config --global --unset url.ssh://git@github.com/.insteadof
  git config --global url.https://github.com/.insteadof=ssh://git@github.com/
fi

# setup vim
vim +PlugInstall +qall
