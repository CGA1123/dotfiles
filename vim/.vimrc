" load plugins with vim-plug
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'majutsushi/tagbar'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-test/vim-test'
Plug 'meain/vim-jsontogo'
Plug 'darfink/vim-plist'

if has('nvim')
  Plug 'dense-analysis/ale'
  Plug 'pwntester/octo.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ellisonleao/glow.nvim', {'branch': 'main'}
endif
call plug#end()

"" infinite, persisted undo
if !isdirectory($HOME."/.vim/undodir")
  call mkdir($HOME."/.vim/undodir", "p", 0700)
endif
set undofile
set undodir=~/.vim/undodir

" enable matchit
runtime macros/matchit.vim

" get syntax highlighting
syntax on

" enable filetype stuff
filetype plugin indent on

" show line numbers
set number
set relativenumber

" highlight current line
set cursorline
set cursorcolumn

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
set tabstop=4

" set incremental search (try to find as we type)
set incsearch

" show column, line number in bottom left
set ruler

" tab completion commands!
set wildmenu

" Set autoread
set autoread

" theme
set background=dark
set termguicolors
silent! colorscheme one

" Set colorcolum
set colorcolumn=81,101

" Don't clutter working dir with swp files
set swapfile
set dir=~/tmp

" Fix blotchy background when using vim within tmux
set t_ut=

" Show whitespace characters
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list

" Show unwanted whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Stop netrw from creating annoying file
let g:netrw_dirhistmax = 0

" remap ESC to § (for touchbar mac)
nmap § <ESC>
imap § <ESC>
vmap § <ESC>

" Change cursor look in normal/edit modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set showcmd

" TagBar
nmap <c-H> :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_width=60
let g:tagbar_show_visibility=1

" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_code_completion_enabled = 0
let g:go_def_mode="gopls"
let g:go_info_mode="gopls"

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')

" coc.nvim
let g:coc_global_extensions = [
  \ 'coc-solargraph',
  \ 'coc-tsserver'
  \ ]
let g:coc_disable_startup_warning = 1

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" <C-space> for completion
inoremap <silent><expr> <c-@> coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" tab completion
" Use tab for trigger completion with characters ahead and navigate.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" always show statusline
set laststatus=2

" C-p for fuzzy file finding
nnoremap <C-p> :Files<Cr>

" C-s for search
nnoremap <C-s> :Ag<Cr>

" load .bashrc in terminal ! commands.
" set shellcmdflag=-ic

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

set bg=light

let g:glow_style = "light"

" ALE
let g:ale_linters = {'go': ['golangci-lint', 'gofmt', 'gopls']}

" TODO: make this pretty...
highlight ALEVirtualTextWarning guifg=Grey guibg=Yellow
highlight ALEVirtualTextError guifg=#eaeaea guibg=#ff3333

" ctags
set tags^=./.git/tags;
