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

Plugin 'tomasr/molokai'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'godlygeek/Tabular'
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" configure airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '#(/home/chirag/bin/uptime.sh)',
      \'y'    : '%R',
      \'z'    : '#H'}

" disable unicode arrows in airline
let g:airline_left_sep=''
let g:airline_right_sep=''

" show line numbers relative to current line
set number

" make vim pretty
set background=dark

try
    colorscheme molokai
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
" refresh all buffers
fun! RefreshBuffers()
  set noconfirm
  bufdo e!
  set confirm
endfun
nnoremap <Leader>gr call RefreshBuffers()
" enable replace of word under cursor (shortcut <space> s)
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" quick save
nnoremap <Leader>w :w<CR>
" remove highlighting
nnoremap <Leader>h :noh<CR>

" make good tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set cindent

" fix backspace
set backspace=indent,eol,start

" remove delay for block edits
set timeoutlen=1000 ttimeoutlen=0
