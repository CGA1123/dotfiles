# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="spaceship"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# load plugins
plugins=(git rails ruby z)

# User configuration
source $ZSH/oh-my-zsh.sh

export PATH="$HOME/bin:$HOME/local/bin:/usr/local/sbin:$PATH"

# Tell GPG what to use to prompt password
export GPG_TTY=$(tty)

# Tell tmux to behave, make vim pretty
export TERM=xterm-256color

DEFAULT_USER='christiangregg'

# Type `clear` takes too long...
alias clr='/usr/bin/clear'

# load local config
function load_config () {
	local PATH_TO_CONFIG=${1}
	if [ -f "${PATH_TO_CONFIG}" ]; then
		echo "Loading Local Config... [${PATH_TO_CONFIG}]"
		source "${PATH_TO_CONFIG}"
	  echo "Loaded."
	else
	    echo "${PATH_TO_CONFIG} not found."
	fi
}

load_config "${HOME}/.zshrc.local"

export SPACESHIP_EXIT_CODE_SHOW=true
export SPACESHIP_BATTERY_SHOW=false
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_PROMPT_ADD_NEWLINE=false
