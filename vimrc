execute pathogen#infect()
syntax on
set number

" Set autoread
set autoread

" tabs
set noexpandtab
set tabstop=4
set shiftwidth=4

set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list
" Use tmuxline
let g:airline#extensions#tmuxline#enabled = 1
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

