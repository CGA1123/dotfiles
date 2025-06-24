source "${HOME}/.colour.sh"
source "${HOME}/.abbreviations.sh"
source "${HOME}/.prompt.sh"

function prompter() {
  export PS1="$(ps1_prompt)"
}

PROMPT_COMMAND=prompter

# tell macOS to stop telling me about zsh
export BASH_SILENCE_DEPRECATION_WARNING=1

DOTFILES_DIR=$(dirname $(dirname $(readlink -f ${BASH_SOURCE[0]})))
ASDF_DATA_DIR="${HOME}/.asdf"

export GOPATH=$(go env GOPATH)
export PATH="${ASDF_DATA_DIR}/shims:${GOPATH}/bin:${PATH}:${HOME}/bin:${DOTFILES_DIR}/script"
export EDITOR=vim
export DISABLE_SPRING=1

## History
# Avoid duplicates
HISTSIZE=50000
HISTFILESIZE=10000
HISTCONTROL="ignoredups"
HISTIGNORE="clear:history:[bf]g:exit:date"

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

function historymerge {
    history -n; history -w; history -c; history -r;
}
trap historymerge EXIT

export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2

eval "$(mcfly init bash)"

ulimit -n 2048

# put local config and config that shouldn't be checked into git into local.sh
[[ -f "${HOME}/.local.sh" ]] && source "${HOME}/.local.sh"
