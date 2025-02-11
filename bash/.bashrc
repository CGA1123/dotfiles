source "${HOME}/.colour.sh"
source "${HOME}/.abbreviations.sh"
source "${HOME}/.prompt.sh"

# put local config and config that shouldn't be checked into git into local.sh
[[ -f "${HOME}/.local.sh" ]] && source "${HOME}/.local.sh"

function prompter() {
  export PS1="$(ps1_prompt)"
}

PROMPT_COMMAND=prompter

# tell macOS to stop telling me about zsh
export BASH_SILENCE_DEPRECATION_WARNING=1

DOTFILES_DIR=$(dirname $(dirname $(readlink -f ${BASH_SOURCE[0]})))

export GOPATH=$(go env GOPATH)
export PATH="${GOPATH}/bin:${PATH}:${HOME}/bin:${DOTFILES_DIR}/script"
export EDITOR=vim
export DISABLE_SPRING=1

## History
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

touch "${HOME}/.bash_history"

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=true

eval "$(mcfly init bash)"

ulimit -n 2048
