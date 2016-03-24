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
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'

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

" configure YCM compile flags for C/C++ semantic checking
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-Tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-S-tab>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-tab>'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'

" show line numbers relative to current line
set number

" make vim pretty
set background=dark
colorscheme molokai
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
