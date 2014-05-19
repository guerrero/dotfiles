version 7.0

" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable Vi compatibility, must be at top
set nocompatible

" Use zshell instead of bash
set shell=/bin/zsh

" Use UTF-8 without BOM
set encoding=utf8 nobomb

" Use the OS clipboard by default (on versions with `+clipboard`)
set clipboard=unnamed

" Disable error bells
set noerrorbells

" Don’t show the intro message when starting Vim
set shortmess=atI

" Behaviour settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Reload file in Vim if it has been changed outside
set autoread

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Highlight current line
set cursorline

" Highlight searches dynamically as pattern is typed
set hlsearch
set incsearch

" Ignore case except if search has uppercase
set ignorecase
set smartcase

" Set max text width
set textwidth=80

" Use 2 spaces for indent and
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Use backspace for all
set backspace=indent,eol,start

" Indentation
set autoindent
set smartindent

" Add the g flag to search/replace by default
set gdefault
"
" Set commands autocompletion and longest selection
set wildmenu
set wildmode=longest:full,full

" Ignore this files
set wildignore=*.swp,*.bak,*.pyc,*.pyo,*.class,*.tmp,*~

set complete=.,w,t

" Show tab and trailing whitespace
set list listchars=tab:..,trail:·

" Don’t add empty newlines at the end of files
set binary
set noeol

" UI settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting and use custom color scheme
syntax enable
colorscheme scheme

" Show line number
set number

" Show the filename in the window titlebar
set title

" Display file and cursor position
set ruler

" Always show status line
set laststatus=2

" Vim directories
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save swp files to a less annoying place than the current directory.
set directory=~/.vim/swaps//

" Save backups to a less annoying place than the current directory.
set backupdir=~/.vim/backups/
set backup

" Keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :setlocal spell! spelllang=en_us<CR>

" Vundle config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Path where Vundle should install plugins
call vundle#begin('~/.vim/bundle/')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Ctrlp utility
Plugin 'kien/ctrlp.vim'
let g:indentLine_char = "⋮"
let g:indentLine_noConcealCursor = 1

" Display an indent line
Plugin 'Yggdroot/indentLine'

 " ds/cs/ys for deleting or changing surrounding chars
Plugin 'tpope/vim-surround'

" Enable Sublime's multiple cursors feature
Plugin 'terryma/vim-multiple-cursors'

" Improve status line  style
Plugin 'bling/vim-airline'

" Syntax plugins
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

