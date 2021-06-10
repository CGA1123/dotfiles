source "${HOME}/.colour.sh"
source "${HOME}/.abbreviations.sh"
source "${HOME}/.git-prompt.sh"
source "${HOME}/.prompt.sh"

PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
