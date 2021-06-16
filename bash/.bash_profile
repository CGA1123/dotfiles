eval "$(/opt/homebrew/bin/brew shellenv)"

source "$(brew --prefix asdf)/asdf.sh"
source "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
source "$(brew --prefix)/etc/profile.d/bash_completion.sh"

source "${HOME}/.bashrc"
