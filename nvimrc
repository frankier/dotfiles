""" Vim config
nnoremap <silent> <C-p> :CtrlP<CR>

" General
set mouse=a

" Editing preferences
set virtualedit=onemore     " Allow for cursor beyond last character

" Presentation preferences
set wrap                    " Wrap lines
set nofoldenable            " Folds suck

" Buffers/files
set history=1000            " Store a ton of history (default is 20)
set hidden                  " Allow buffer switching without saving
set backup                  " Backups are nice ...
set undofile                " So is persistent undo ...
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload

" Extra indicators
set number                  " Line numbers on
set showmatch               " Show matching brackets/parenthesis
set incsearch               " Find as you type search
set hlsearch                " Highlight search terms

""" Plugins config

" Use python 2 for python-client
let g:python_host_prog='/usr/bin/python2'

" Ctrl-P
nnoremap <silent> <C-b> :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" YCM
let g:ycm_collect_identifiers_from_tags_files = 1
set completeopt-=preview

" XXX: Find out how this works
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" Stop gitgutter blocking ui
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

""" Extra commands

" C-X to swap visual with yanked.
:vnoremap <C-X> <Esc>`.``gvP``P

""" Bootstrap vim-plug

if !isdirectory(expand("~/.nvim"))
  silent exec "!mkdir -p ~/.nvim/autoload"
  silent exec "!mkdir -p ~/.nvim/plugged"
  silent exec "!curl -fLo ~/.nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

""" Bundles

call plug#begin(expand('~/.nvim/plugged'))

Plug 'junegunn/vim-plug'

" Core 'text editor' settings and shortcuts
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'terryma/vim-multiple-cursors'
Plug 'mbbill/undotree'

" File/buffer management and search
Plug 'vim-scripts/bufkill.vim'
Plug 'bling/vim-bufferline'
Plug 'kien/ctrlp.vim'

" Colorschemes
Plug 'altercation/vim-colors-solarized'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Search
Plug 'rking/ag.vim'

" Multiple language plugins
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'

" Markup/data languages
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'

" Programming
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go'
Plug 'python-rope/ropevim'
Plug 'mxw/vim-jsx'

call plug#end()
