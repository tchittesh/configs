" Plugin manager setup
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif 

nnoremap k gk
nnoremap j gj
let mapleader = " "
nmap <nowait> <leader>/ <plug>NERDCommenterToggle
vmap <nowait> <leader>/ <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 
      \ 'c': { 'left': '/**','right': '*/' },
      \ 'cpp': { 'left': '/**','right': '*/' } 
      \ }

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown' 
Plug 'lervag/vimtex'
Plug 'jez/vim-better-sml'
Plug 'rakr/vim-one'
Plug 'preservim/nerdcommenter'

" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } 
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'zchee/deoplete-jedi'
let g:deoplete#enable_at_startup = 1

call plug#end()


" Terminal stuff
set lazyredraw
set linebreak
set showcmd
set mouse=a " mouse clicks
set wildmenu " visual autocomplete for command menu
set incsearch " search as characters are entered
set ruler
set number
set cursorline
syntax enable
highlight Comment cterm=italic

" Vim-One Theme
" set background=dark
" colorscheme one
" let g:one_allow_italics = 1 " I love italic for comments
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Text editing
set tabstop=4 softtabstop=2 expandtab shiftwidth=4 smarttab
filetype plugin indent on


" Search
"set spell spelllang=en_us
set ignorecase
set smartcase
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Airline
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1

" Vim markdown
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1

" Vim-tex
"let g:vimtex_quickfix_mode = 1
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
let g:vimtex_quickfix_open_on_warning = 0
let g:tex_conceal = ''
let g:tex_flavor = 'latex'
let g:vimtex_latexmk_continuous = 1
let g:vimtex_view_enabled = 1
let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_compiler_callback_hooks = ['UpdateSkim']

function! UpdateSkim(status)
    if !a:status | return | endif

    let l:out = b:vimtex.out()
    let l:tex = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']

    if !empty(system('pgrep Skim'))
        call extend(l:cmd, ['-g'])
    endif

    if has('nvim')
        call jobstart(l:cmd + [line('.'), l:out, l:tex])
    elseif has('job')
        call job_start(l:cmd + [line('.'), l:out, l:tex])
    else
        call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
    endif
endfunction

" This is new style
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" Deoplete
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-Tab>"
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
highlight Pmenu ctermbg=8 guibg=#606060
highlight PmenuSel ctermbg=7 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

"call deoplete#custom#var('omni', 'input_patterns', {
"          \ 'tex': g:vimtex#re#deoplete
"          \})

" Python
let g:python_host_prog = '/usr/local/opt/python@3.8/bin/python3'


