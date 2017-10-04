" map leader character to space
let mapleader = "\<Space>"

let g:vundle_default_git_proto = 'git'

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-scripts/wombat256.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'edkolev/tmuxline.vim'
Plugin 'godlygeek/Tabular'
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" configure airline
let g:airline_theme = 'wombat'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_symbols_ascii = 1
set noshowmode

let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'y'    : '%R',
      \'z'    : '#H'}

" show line numbers relative to current line
set number

" set colorscheme, if it exists
try
    colorscheme wombat256mod
catch /^Vim\%((\a\+)\)\=:E185/
endtry

set t_Co=256
set t_ut=

" enable syntax highlighting
syntax on

" highlight cursor
set cursorline

" buffer lines when scrolling
set scrolloff=2

" always have status line
set laststatus=2

" turn off wrapping
set nowrap

" change Y behavior to yank from cursor to end of line
nnoremap Y y$

" syntax highlight glsl files
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

" make seaching nicer
set hlsearch
set incsearch
set ignorecase
set smartcase

" prevent vim from adding ^M
set binary

" leader commands
" enable replace of word under cursor (shortcut <space> s)
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" quick save
nnoremap <Leader>w :w<CR>
" remove highlighting
nnoremap <Leader>h :noh<CR>
" destroy buffer
nnoremap <Leader>q :bd<CR>

" make good tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set cindent

" fix backspace
set backspace=indent,eol,start

" remove delay for block edits
set timeoutlen=1000 ttimeoutlen=0
