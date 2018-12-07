if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

if g:os != "Windows"
    "
    " VUNDLE
    "
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin() " let Vundle manage Vundle, required

    Plugin 'gmarik/Vundle.vim'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'rickhowe/diffchar.vim'
    "Plugin 'tmhedberg/SimpylFold'
    "Plugin 'Yggdroot/indentLine'
    Plugin 'vim-scripts/indentpython.vim'
    Plugin 'scrooloose/syntastic'
    Plugin 'nvie/vim-flake8'
    Plugin 'jnurmine/Zenburn'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'kien/ctrlp.vim'
    "Plugin 'python-mode/python-mode'
    Plugin 'tpope/vim-fugitive'
    Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
    Plugin 'scrooloose/nerdtree'
    Plugin 'aperezdc/vim-template'
    Plugin 'vim-voom/VOoM' " two pane outliner
    Plugin 'henrik/vim-indexed-search'
    Plugin 'leafgarland/typescript-vim'
    Plugin 'Quramy/vim-js-pretty-template'
    Plugin 'burnettk/vim-angular'

    call vundle#end()

    " https://github.com/VundleVim/Vundle.vim/issues/679
endif

filetype plugin on
filetype plugin indent on

"
" DIRECTIVES
" 
syntax on
set clipboard=unnamed           " use system clipboard
set splitbelow
set splitright
set foldmethod=indent           " Enable folding
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
"set relativenumber
"set number
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
set laststatus=2                " Always set a status line
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

let g:Powerline_symbols = 'fancy'

let python_highlight_all=1
let g:SimpylFold_docstring_preview=1


" python-mode
"set completeopt=menu
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" https://robots.thoughtbot.com/opt-in-project-specific-vim-spell-checking-and-word-completion
set complete+=kspell

" KEYMAPS
" 
" remap CTRL+N to CTRL + space XXX remove?
inoremap <Nul> <C-n>

" navigation in windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

vmap <C-R> ! python /Users/uzak/work/sandbox/python/reformat.py <cr>

nnoremap th :tabfirst<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap tt :tabedit<Space>
nnoremap td :tabclose<CR>

nnoremap <F8> :make html<CR>
nnoremap <F9> :make compile<CR>
nnoremap <F10> :make test<CR>
nnoremap <F11> :make build<CR>
nnoremap <F12> :make deploy<CR>

"
" leader keys
"
nmap <leader>d :Gdiff :0<CR>
nmap <leader>t :NERDTreeToggle<CR>

" Enable folding with the spacebar
nnoremap <space> za             

" add spellchecking on ,c
nnoremap <leader>de :setlocal spell spelllang=de<CR>
nnoremap <leader>en :setlocal spell spelllang=en<CR>
nnoremap <leader>pt :setlocal spell spelllang=pt<CR>
nnoremap <leader>sk :setlocal spell spelllang=sk<CR>
" http://vimdoc.sourceforge.net/htmldoc/spell.html
" z= zG zg

"
" FILETYPES
"
filetype plugin indent on       "customizable indendation per file type

au BufNewFile,BufRead *.py 
    \ set tabstop=4 | 
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix 

au BufNewFile,BufRead *.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

au BufRead,BufNewFile *.conf setf dosini

au FocusLost * :wa

" ctrlP
let g:ctrlp_map = '<leader><leader>'
set wildignore+=*/build/**
let g:ctrlp_use_caching=0

" aperezdc/vim-template
let g:templates_directory='~/repos/dotfiles/.vim-templates'
let g:email='martin.uzak@gmail.com'
let g:username='Martin Užák'

if g:os != "Windows"
    " syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    " syntastic checker
    nnoremap <leader>syn :SyntasticCheck<CR>
endif


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

if has("gui_running")
    set number
endif

if has("mac")
    set guifont=Inconsolata\ for\ Powerline:h14
elseif has("unix")
    set guifont=Inconsolata\ for\ Powerline\ 12
endif

" https://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

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
let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "t480s"
    colorscheme solarized
    set background=light
endif

