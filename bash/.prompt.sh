SYMB_SEGMENT_L=""
SYMB_SEGMENT_R=""
SYMB_GIT_BRANCH=""
SYMB_GIT_DETACHED="➤"
SYMB_GIT_STASHED="╍╍"
SYMB_GIT_AHEAD="+ "
SYMB_GIT_BEHIND="- "
SYMB_GIT_AHEAD_BEHIND="-+ "

function git_branch_name() {
  git symbolic-ref --short HEAD 2>/dev/null \
    || command git describe --tags --exact-match HEAD 2>/dev/null \
    || command git rev-parse --short HEAD 2>/dev/null
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

# TODO:
# f segment
# f segment_close
# f segment_right
# f segment_right
# gv SEGMENT
# gv SEGMENT_COLOR
#
# - last status
# - last command duration
