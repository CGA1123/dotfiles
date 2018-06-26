# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rails ruby z)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
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
		echo "Loading Local Config... [${HOME}/.zshrc.local]"
		source "${PATH_TO_CONFIG}"
	  echo "Loaded."
	else
	    echo "${PATH_TO_CONFIG} not found."
	fi
}

load_config "${HOME}/.zshrc.local"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export SPACESHIP_EXIT_CODE_SHOW=true
export SPACESHIP_BATTERY_SHOW=always
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_PROMPT_ADD_NEWLINE=false
