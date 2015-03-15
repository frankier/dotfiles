""" Vim config

" Presentation preferences
set nofoldenable            " Folds suck

" Extra indicators
set showmatch               " Show matching brackets/parenthesis
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

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

" JSX
let g:jsx_ext_required = 0

" vim-json
let g:vim_json_syntax_conceal = 0

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
Plug 'frankier/vim-pretty-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'terryma/vim-multiple-cursors'
Plug 'mbbill/undotree'

" File/buffer management and search
Plug 'vim-scripts/bufkill.vim'
Plug 'bling/vim-bufferline'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-eunuch'
Plug 'rking/ag.vim'

" Colorschemes
Plug 'altercation/vim-colors-solarized'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Multiple language plugins
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'

" Markup/data languages
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'

" Programming
Plug 'pangloss/vim-javascript'
Plug 'marijnh/tern_for_vim'
Plug 'fatih/vim-go'
Plug 'python-rope/ropevim'
Plug 'mxw/vim-jsx'

" Meta
Plug 'tpope/vim-scriptease'

call plug#end()
