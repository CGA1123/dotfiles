" load pathogen
execute pathogen#infect()

" get syntax highlighting
syntax on

" enable filetype stuff
filetype plugin indent on

" show line numbers
set number

" highlight current line
set cursorline

" utf-8 ftw
set encoding=utf-8

" keep 8 lines below when scrolling
set scrolloff=8

set backspace=indent,eol,start
set autoindent
set smarttab

" set incremental search (try to find as we type)
set incsearch

" show column, line number in bottom left
set ruler

" tab completion commands!
set wildmenu

" Set autoread
set autoread

" Show whitespace characters
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list

" theme
set background=dark
set termguicolors
colorscheme material

" Set colorcolum
set colorcolumn=81,101

" Show hidden file in ctrlp
let g:ctrlp_show_hidden = 1

" Don't clutter working dir with swp files
set swapfile
set dir=~/tmp

" Fix blotchy background when using vim within tmux
set t_ut=

" Show unwanted whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Stop netrm from creating annoying file
let g:netrw_dirhistmax = 0

" remap ESC to § (for touchbar mac)
inoremap § <ESC>

" set zsh as shell
set shell=/bin/zsh
