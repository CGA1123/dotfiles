#!/usr/bin/env bash

set -euo pipefail

# install homebrew
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install Brewfile
brew bundle

# initialize submodules
git submodule update --init --recursive

# make sure some dirs exist
mkdir -p "${HOME}/.config/fish"
mkdir -p ${HOME}/tmp

# setup dotfiles
stow fish --target "${HOME}/.config/fish"
stow git --target "${HOME}"
stow rspec --target "${HOME}"
stow tmux --target "${HOME}"
stow vim --target "${HOME}"

# setup fish
FISH=$(which fish)
sudo bash -c "echo \"${FISH}\" > /etc/shells"
chsh -s "${FISH}"
${FISH} -c "curl -sL https://git.io/fisher | source && fisher install --force jorgebucaran/fisher"
${FISH} -c "fisher install"
${FISH} -c "asdf plugin add ruby"
${FISH} -c "asdf plugin add nodejs"
${FISH} -c "asdf install ruby 2.7.1"
${FISH} -c "asdf install nodejs 14.17.0"
${FISH} -c "asdf global ruby 2.7.1"
${FISH} -c "asdf global nodejs 14.17.0"

# setup vim
vim +PlugInstall +qall
