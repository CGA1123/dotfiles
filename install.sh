#!/usr/bin/env bash

set -euo pipefail

RUBY_VERSION="2.7.2"
NODE_VERSION="14.17.0"

function brew_installed() {
  local KERNEL=$(uname -s)
  local ARCH=$(uname -p)

  case "${KERNEL}-${ARCH}" in
    Darwin-arm)
      test -d /opt/Homebrew
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
      echo "/opt/Homebrew"
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

# install homebrew, if it isn't already
brew_installed > /dev/null 2>&1 || /bin/bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"

# install Brewfile
eval "$(brew_dir)/bin/brew bundle --verbose"

# initialize submodules
git submodule update --init --recursive

# make sure some dirs exist
mkdir -p ${HOME}/tmp

asdf_plugin_install "ruby"
asdf_plugin_install "nodejs"

asdf install ruby "${RUBY_VERSION}"
asdf global ruby "${RUBY_VERSION}"

asdf install nodejs "${NODE_VERSION}"
asdf global nodejs "${NODE_VERSION}"

# setup vim
vim +PlugInstall +qall

# setup dotfiles
stow bash --target "${HOME}"
stow git --target "${HOME}"
stow rspec --target "${HOME}"
stow tmux --target "${HOME}"
stow vim --target "${HOME}"
