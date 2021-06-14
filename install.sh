#!/usr/bin/env bash

set -euo pipefail

# install homebrew, if it isn't already
which -s brew || /bin/bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"

# install Brewfile
brew bundle

# initialize submodules
git submodule update --init --recursive

# make sure some dirs exist
mkdir -p ${HOME}/tmp

# setup dotfiles
stow bash --target "${HOME}"
stow git --target "${HOME}"
stow rspec --target "${HOME}"
stow tmux --target "${HOME}"
stow vim --target "${HOME}"

RUBY_VERSION="2.7.2"
NODE_VERSION="14.17.0"

function asdf_plugin_install () {
  local plugin=${1}

  if ! $(asdf plugin list | grep -q "${plugin}"); then
    asdf plugin add "${plugin}"
  fi
}

asdf_plugin_install "ruby"
asdf_plugin_install "nodejs"

asdf install ruby "${RUBY_VERSION}"
asdf global ruby "${RUBY_VERSION}"

asdf install nodejs "${NODE_VERSION}"
asdf global nodejs "${NODE_VERSION}"

# setup vim
vim +PlugInstall +qall
