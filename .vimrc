filetype plugin on
filetype plugin indent on

"
" directives
" 
syntax on
set clipboard=unnamed           " use system clipboard
set splitbelow
set splitright
set foldmethod=indent           " enable folding
set foldlevel=99
set nocompatible
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
"set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set noundofile 
let mapleader = ","
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set autowrite
set background=dark
colorscheme zellner
"colorscheme peachpuff

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80
"set list
set listchars=tab:▸\ ,eol:¬

set acd                         " auto change directory
set laststatus=2                " always set a status line
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" python-mode
"set completeopt=menu
autocmd cursormovedi * if pumvisible() == 0|pclose|endif
autocmd insertleave * if pumvisible() == 0|pclose|endif

" https://robots.thoughtbot.com/opt-in-project-specific-vim-spell-checking-and-word-completion
set complete+=kspell

" keymaps
" 
" remap ctrl+n to ctrl + space xxx remove?
inoremap <nul> <c-n>

" navigation in windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap th :tabfirst<cr>
nnoremap tk :tabnext<cr>
nnoremap tj :tabprev<cr>
nnoremap tl :tablast<cr>
nnoremap tt :tabedit<space>
nnoremap td :tabclose<cr>

nnoremap <f8> :make html<cr>
nnoremap <f9> :make compile<cr>
nnoremap <f10> :make test<cr>
nnoremap <f11> :make build<cr>
nnoremap <f12> :make deploy<cr>

"
" leader keys
" enable folding with the spacebar
nnoremap <space> za             

" add spellchecking on ,c
nnoremap <leader>de :setlocal spell spelllang=de<cr>
nnoremap <leader>en :setlocal spell spelllang=en<cr>
nnoremap <leader>pt :setlocal spell spelllang=pt<cr>
nnoremap <leader>sk :setlocal spell spelllang=sk<cr>
" http://vimdoc.sourceforge.net/htmldoc/spell.html
" z= zg zg

"
" filetypes
"
filetype plugin indent on       "customizable indendation per file type

au bufnewfile,bufread *.py 
    \ set tabstop=4 | 
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix 

au bufnewfile,bufread *.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

au bufread,bufnewfile *.c set noexpandtab
au bufread,bufnewfile *.h set noexpandtab
au bufread,bufnewfile makefile* set noexpandtab

au bufread,bufnewfile *.conf setf dosini

au focuslost * :wa

" vimdiff
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

" typescript
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab

"
" host based settings
" 
"let hostname = substitute(system('hostname'), '\n', '', '')
"if hostname == "t480s"
"endif

if has("gui_running")
    set number
    "colorscheme solarized
    set background=light
endif

if has("mac")
    set guifont=Inconsolata\ for\ Powerline:h14
elseif has("unix")
    set guifont=Monospace\ 11
elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
endif

if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

if g:os == "Windows"
    "let skip_defaults_vim=1
    "set viminfo=""
endif
