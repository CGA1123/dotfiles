# ls
alias ls="ls -G"
alias ll="ls -l"
alias la="ls -la"

# git
alias g="git"
alias ga="g a"
alias gs="g s"
alias gd="g d"
alias gds="g ds"
alias push="git push --force-with-lease"

# other
alias b="bundle"
alias be="bundle exec"
alias v="vim"
alias vi="vim"
alias clr="clear"
alias vim="nvim"
alias vvim="/usr/bin/env vim"
alias tf="terraform"

function gc() {
  local nwo="${1}"
  local dst="${HOME}/${nwo}"

  mkdir -p "${dst}"
  git clone "git@github.com:${nwo}" "${dst}"
}

function bb() {
  open "https://cs.github.com?q=${1}"
}

function cs() {
  open "https://cs.github.com?q=${1}"
}
