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
COLOUR_RESET="0"

function colour() {
  printf "\[\e[${1}m\]"
}

function colour_background() {
  if [[ "${1}" -eq "${COLOUR_RESET}" ]]; then
    colour ${1}
  else
    colour "$((${1} + 10))"
  fi
}

function colour_bold() {
  colour 1
}

function colour_faint() {
  colour 2
}

function colour_italic() {
  colour 3
}

function colour_underline() {
  colour 4
}
