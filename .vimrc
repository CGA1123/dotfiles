execute pathogen#infect()
syntax on
filetype plugin indent on
set number

" Breezy (theme)
set background=dark
set termguicolors
colorscheme breezy

" Set colorcolum
set colorcolumn=81,101

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_format = '[%s] '
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='breezy'

" Open NERDTree on vim start (unless we are using git)
autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | endif

" Show hidden files in NERDTree
let NERDTreeShowHidden = 1

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
