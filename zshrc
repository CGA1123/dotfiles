source ${HOME}/.dotfiles/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle heroku
antigen bundle ruby
antigen bundle rails
antigen bundle zsh-users/zsh-autosuggestions
antigen theme sunrise
antigen apply

export PATH="$HOME/bin:$HOME/local/bin:/usr/local/sbin:$PATH"

# Tell GPG what to use to prompt password
export GPG_TTY=$(tty)

# Tell tmux to behave, make vim pretty
export TERM=xterm-256color

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
