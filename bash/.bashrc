source "${HOME}/.colour.sh"
source "${HOME}/.abbreviations.sh"
source "${HOME}/.prompt.sh"

function prompter() {
  export PS1="$(ps1_prompt)"
}

PROMPT_COMMAND=prompter

# tell macOS to stop telling me about zsh
export BASH_SILENCE_DEPRECATION_WARNING=1
