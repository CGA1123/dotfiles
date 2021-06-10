COLOUR_BLACK="30"
COLOUR_RED="31"
COLOUR_GREEN="32"
COLOUR_YELLOW="33"
COLOUR_BLUE="34"
COLOUR_MAGENTA="35"
COLOUR_CYAN="36"
COLOUR_LIGHT_GREY="37"
COLOUR_GREY="90"
COLOUR_LIGHT_RED="91"
COLOUR_LIGHT_GREEN="92"
COLOUR_LIGHT_YELLOW="93"
COLOUR_LIGHT_BLUE="94"
COLOUR_LIGHT_MAGENTA="95"
COLOUR_LIGHT_CYAN="96"
COLOUR_WHITE="97"

function colour() {
  printf "\e[${1}m"
}

function colour_background() {
  local bg="$((${1} + 10))"

  colour ${bg}
}

function colour_reset() {
  printf "\e[0m"
}

function colour_bold() {
  printf "\e[1m"
}

function colour_faint() {
  printf "\e[2m"
}

function colour_italic() {
  printf "\e[3m"
}

function colour_underline() {
  printf "\e[4m"
}
