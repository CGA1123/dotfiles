# Homebrew installs to different places on Apple M1 vs Intel
KERNEL=$(uname -s)
ARCH=$(uname -p)

case "${KERNEL}-${ARCH}" in
  Darwin-arm)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
  Darwin-i386)
    eval "$(/usr/local/Homebrew/bin/brew shellenv)"
    ;;
  Linux-*)
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
  *)
    echo "Unknown architecture ${ARCH} - failed to load homebrew shellenv"
    ;;
esac

source "$(brew --prefix asdf)/asdf.sh"
source "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
source "$(brew --prefix)/etc/profile.d/bash_completion.sh"

source "${HOME}/.bashrc"
