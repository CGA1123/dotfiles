# Homebrew installs to different places on Apple M1 vs Intel
ARCH=$(uname -p)
case "${ARCH}" in
  arm)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
  i386)
    eval "$(/usr/local/homebrew/bin/brew shellenv)"
    ;;
  *)
    echo "Unknown architecture ${ARCH} - failed to load homebrew shellenv"
    ;;
esac

source "$(brew --prefix asdf)/asdf.sh"
source "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
source "$(brew --prefix)/etc/profile.d/bash_completion.sh"

source "${HOME}/.bashrc"
