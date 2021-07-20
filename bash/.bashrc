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

export GOPATH=$(go env GOPATH)
export PATH="${GOPATH}/bin:${PATH}"
