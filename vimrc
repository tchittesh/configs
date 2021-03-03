" Ensure that we are in modern vim mode, not backwards-compatible vi mode
set nocompatible
set backspace=indent,eol,start

" Helpful information: cursor position in bottom right, line numbers on
" left
set ruler
set number

"Enable filetype detection and syntax hilighting
syntax on
filetype on
filetype indent on
filetype plugin on

" Indent as intelligently as vim knows how
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab

" Show multicharacter commands as they are being typed
set showcmd

set mouse=a " mouse clicks
set wildmenu " visual autocomplete for command menu
set incsearch " search as characters are entered

