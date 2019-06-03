" load plugins with vim-plug
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/tpope/vim-git'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/vim-ruby/vim-ruby'
Plug 'https://github.com/tpope/vim-rails'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/rhysd/vim-crystal'
Plug 'https://github.com/kana/vim-textobj-user'
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock'
Plug 'https://github.com/joshdick/onedark.vim'
Plug '~/dev/vim-to-github'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()

" Manual Configuration!

" enable matchit
runtime macros/matchit.vim

" get syntax highlighting
syntax on

" enable filetype stuff
filetype plugin indent on

" show line numbers
set number

" highlight current line
"set cursorline
"set cursorcolumn

" yank into system clipboard
set clipboard=unnamed

" utf-8 ftw
set encoding=utf-8

" keep 8 lines below when scrolling
set scrolloff=8

set backspace=indent,eol,start
set autoindent
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2

set updatetime=500

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
colorscheme onedark

" Set colorcolum
set colorcolumn=81,101

" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME . '/tmp'

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
nmap § <ESC>
imap § <ESC>
vmap § <ESC>

" ToGithub
let g:to_github_clip_command = 'pbcopy'
let g:to_github_clipboard = 1

" Change cursor look in normal/edit modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
