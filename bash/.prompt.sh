SYMB_SEGMENT=""
SYMB_GIT_BRANCH=""
SYMB_GIT_DETACHED="➤"
SYMB_GIT_STASHED="╍╍"
SYMB_GIT_AHEAD="+ "
SYMB_GIT_BEHIND="- "
SYMB_GIT_DIVERGED="-+ "
SEGMENT_COLOUR="${COLOUR_RESET}"

function host_info() {
  local host=$(uname -n)

  id -un | awk -v host="${host}" '
    BEGIN { format = "user@host" }
    {
        user = $0
        if (!sub("usr", substr(user, 1, 1), format)) {
            sub("user", user, format)
        }
        len = split(host, host_info, ".")
        sub("host", host_info[1], format)
        sub("domain", len > 1 ? host_info[2] : "", format)
        print(format)
    }
  '
}

function get_pwd_info() {
  pwd -P | awk -v home="$(echo ~)" \
    -v git_root="$(git rev-parse --show-toplevel 2> /dev/null)" \
    -v separator="/" \
    -v dir_length="" '
  function base(string) {
      sub(/^\/?.*\//, "", string)
      return string
  }
  function dirs(string, printLastName,   prefix, path) {
      len = split(string, parts, "/")
      for (i = 1; i < len; i++) {
          name = dir_length == 0 ? parts[i] : substr(parts[i], 1, dir_length ? dir_length : 1)
          if (parts[i] == "" || name == ".") {
              continue
          }
          path = path prefix name
          prefix = separator
      }
      return (printLastName == 1) ? path prefix parts[len] : path
  }
  function remove(thisString, fromString) {
      sub(thisString, "", fromString)
      return fromString
  }
  {
      if (git_root == home) {
          git_root = ""
      }
      if (git_root == "") {
          printf("%s\n%s\n%s\n",
              $0 == home || $0 == "/" ? "" : base($0),
              dirs(remove(home, $0)),
              "")
      } else {
          printf("%s\n%s\n%s\n",
              base(git_root),
              dirs(remove(home, git_root)),
              $0 == git_root ? "" : dirs(remove(git_root, $0), 1))
      }
  }
  '
}

function git_branch_name() {
  git symbolic-ref --short HEAD 2>/dev/null \
    || command git describe --tags --exact-match HEAD 2>/dev/null \
    || command git rev-parse --short HEAD 2>/dev/null
}

function git_ahead() {
  local ahead=${SYMB_GIT_AHEAD}
  local behind=${SYMB_GIT_BEHIND}
  local diverged=${SYMB_GIT_DIVERGED}
  local none=""

  git rev-list --count --left-right "@{upstream}...HEAD" 2>/dev/null | command awk "
        /^0\t0/         { print \"$none\"       ? \"$none\"     : \"\";     exit 0 }
        /^[0-9]+\t0/    { print \"$behind\"     ? \"$behind\"   : \"-\";    exit 0 }
        /^0\t[0-9]+/    { print \"$ahead\"      ? \"$ahead\"    : \"+\";    exit 0 }
        //              { print \"$diverged\"   ? \"$diverged\" : \"±\";    exit 0 }
    "
}

function git_is_repo() {
  git rev-parse --git-dir > /dev/null 2>/dev/null
}

function git_is_staged() {
  git_is_repo && ! git diff --cached --no-ext-diff --quiet --exit-code 2>/dev/null
}

function git_is_dirty() {
  git_is_repo && ! git diff --no-ext-diff --quiet --exit-code 2>/dev/null

}

function git_is_touched() {
  git_is_staged || git_is_dirty
}

function git_is_detached_head() {
  ! git symbolic-ref --quiet HEAD >/dev/null 2>&1
}

function git_is_stashed() {
  git rev-parse --verify --quiet refs/stash > /dev/null 2>/dev/null
}

function segment() {
  local fg=${1}
  local bg=${2}
  local text=${3}

  SEGMENT_COLOUR=${SEGMENT_COLOUR:-${COLOUR_RESET}}

  SEGMENT="$(colour ${fg})$(colour_background ${bg})${text}$(colour_background ${SEGMENT_COLOUR})$(colour ${bg})${SYMB_SEGMENT}${SEGMENT}"
  SEGMENT_COLOUR=${bg}
}

function segment_close() {
  printf "${SEGMENT}$(colour ${COLOUR_RESET}) "

  SEGMENT_COLOUR=""
  SEGMENT=""
}

function ps1_prompt() {
  local status=$?
  local branch=$(git_branch_name)
  local git_glyph=${SYMB_GIT_BRANCH}
  local git_colours=(${COLOUR_BLACK} ${COLOUR_GREEN})
  local dir=""
  local base=""
  local base_colour=(${COLOUR_LIGHT_GREY} ${COLOUR_GREY})
  local pwd_info=()

  # need to do this shenanigans to support empty lines!
  while IFS='' read -r line; do
    pwd_info+=("$line")
  done  < <(get_pwd_info)

  if [[ "${PWD}" = ~ ]]; then
    base="~"
  elif [[ "${PWD}" == $(echo ~)* ]]; then
    dir="~/"
  else
    if [[ "${PWD}" != / ]]; then
      dir="/"
    fi

    base="$(colour ${COLOUR_RED})/"
  fi

  if [[ ! -z ${pwd_info[0]} ]]; then
    base="${pwd_info[0]}"
  fi

  if [[ ! -z ${pwd_info[1]} ]]; then
    dir="${dir}${pwd_info[1]}/"
  fi

  if [[ ! -z ${pwd_info[2]} ]]; then
    segment ${base_colour[0]} ${base_colour[1]} " ${pwd_info[2]} "
  fi

  if [[ ${branch} != "" ]]; then
    if git_is_staged; then
      git_colours[1]=${COLOUR_YELLOW}

      if git_is_dirty; then
        git_colours[2]=${COLOUR_WHITE}
        git_colours[3]=${COLOUR_RED}
      fi
    elif git_is_dirty; then
      git_colours=(${COLOUR_WHITE} ${COLOUR_RED})
    elif git_is_touched; then
      git_colours=(${COLOUR_WHITE} ${COLOUR_RED})
    fi

    if git_is_detached_head; then
      git_glyph=${SYMB_GIT_DETACHED}
    elif git_is_stashed; then
      git_glyph=${SYMB_GIT_STASHED}
    fi

    local prompt=""
    if [[ "${branch}" = "master" || "${branch}" = "main" ]]; then
      prompt=" ${git_glyph} $(git_ahead)"
    else
      prompt=" ${git_glyph} ${branch} $(git_ahead)"
    fi

    if [[ ${git_colours[2]} != "" ]]; then
      segment ${git_colours[2]} ${git_colours[3]} "${prompt}"
      segment ${COLOUR_BLACK} ${COLOUR_BLACK}
      segment ${git_colours[0]} ${git_colours[1]} " ${git_glyph} "
    else
      segment ${git_colours[0]} ${git_colours[1]} "${prompt}"
    fi
  fi

  segment ${base_colour[0]} ${base_colour[1]} " ${dir}$(colour ${COLOUR_WHITE})${base} "

  if [[ ! -z "${SSH_CLIENT}" ]]; then
    local user_colour=${COLOUR_LIGHT_GREY}

    if [[ $(id -u "${USER}") -eq 0 ]]; then
      user_colour=${COLOUR_RED}
    fi

    segment ${user_colour} ${COLOUR_GREY} " $(host_info) "
  elif [[ $(id -u "${USER}") -eq 0 ]]; then
    segment ${COLOUR_RED} ${COLOUR_GREY} " \$ "
  fi

  segment ${COLOUR_GREY} ${COLOUR_LIGHT_GREY} " $(date +"%T") "

  if [[ ! ${status} -eq 0 ]]; then
    segment ${COLOUR_RED} ${COLOUR_WHITE} "$(colour_bold) ! $(colour ${COLOUR_RESET})"
  elif jobs "%%" > /dev/null 2>&1; then
    segment ${COLOUR_WHITE} ${COLOUR_GREY} " %% "
  fi

  segment_close
}
