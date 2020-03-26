" Setup {{{1

language en_US.UTF-8
set nocompatible
syntax on

" install plug if not available yet
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')

if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif


" fix gx command for gvim (https://github.com/vim/vim/issues/4738#issuecomment-521506447)
if has('gui')
    nmap gx yiW:!firefox <cWORD><CR> <C-r>" & <CR><CR>
endif

" Plugins {{{1
"
call plug#begin("~/.vim/plugged") 

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
" also run: 
"   sudo apt install xdg-utils curl nodejs
"   npm -g install instant-markdown-d

Plug 'aperezdc/vim-template'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'w0ng/vim-hybrid'                  " hybrid colorscheme

Plug 'valloric/MatchTagAlways'          " highlight enclosing html/xml tags 
Plug 'google/vim-searchindex'           " shows  'M/N' matches found
Plug 'mhinz/vim-signify'                " indicate VCS changes 
Plug 'fisadev/vim-isort'                " Automatically sort python imports
Plug 'patstockwell/vim-monokai-tasty'   " A nice colorscheme
Plug 'Shougo/context_filetype.vim'      " Completion from other opened files
Plug 'sheerun/vim-polyglot'             " Better language packs
Plug 'mileszs/ack.vim'                  " Ack code search (requires ack)
Plug 't9md/vim-choosewin'               " Window chooser
Plug 'fisadev/FixedTaskList.vim'        " Pending tasks list

Plug 'gruvbox-community/gruvbox'        " gruvbox colorscheme

Plug 'tpope/vim-obsession'              " better :mksession
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'bronson/vim-visual-star-search'   " search for visual sel. by */#
Plug 'tpope/vim-vividchalk'             " another nice colorschme
Plug 'tpope/vim-commentary'             " comment stuff out (`gcc`/`gc`+motion)

"Plug 'tpope/vim-eunuch'                 " VIM sugar for basix UNIX cmds
"Plug 'mattn/emmet-vim'                " powerful HTML/CSS/JS completion
"Plug 'tpope/vim-dadbod'                 " SQL (modern DB interface) 
"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
"endif
"Plug 'deoplete-plugins/deoplete-jedi'
"Plug 'davidhalter/jedi-vim'

call plug#end()

" Install plugins the first time vim runs
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif



" Options {{{1

"set acd                  " auto change directory
"set list
let mapleader = ","
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus       " use system clipboard
set colorcolumn=80
set complete+=kspell
set encoding=utf-8
set expandtab
set fileformat=unix
set foldlevel=99
set foldmethod=marker
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set listchars=extends:»,precedes:«,trail:·,tab:⇥\ ,eol:↵,space:␣
set mouse=a
set nojoinspaces
set noswapfile
set path+=**            " https://www.youtube.com/watch?v=XA2WjJbmmoM
set scrolloff=3         " keep cursor 3 lines away from screen border
set shiftround
set shiftwidth=4
set showbreak=\\
set showcmd
set showmatch
set showmode
set smartcase
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set timeoutlen=500      " how long we wait for another keypress
"set ttyfast
set wildignorecase
set wildmenu
set wildmode=list:longest,list:full
set wrap
set wrapscan
set background=dark
set number

colorscheme zellner

" deactivate syntax highlighting when diffing
if &diff
  syntax off
endif

" backup, undo and viminfo file

set backup
set undofile                      " undo after you re-open the file
set backupdir=~/.vim/backups " where to put backup files
set undodir=~/.vim/undos

if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif

" OS specific {{{2

if has("win32")
    let skip_defaults_vim = 1
    set viminfo = ""
endif

if has("mac")
    set guifont=Inconsolata\ for\ Powerline:h14
elseif has("unix")
    set guifont=Monospace\ 13
elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
endif

" GUI options {{{2
if has("gui_running")
    set background=light
endif



" Autocommands {{{1

filetype plugin indent on       "customizable indendation per file type

" define a group `init` and initialize.
augroup init
    autocmd!

    " Remember last location/cursor in file
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " Autoresize windows/splits when vim resizes
    autocmd VimResized * wincmd =

    " spell correction on markdown files and mail (for mutt)
    autocmd FileType mail,markdown setlocal spell
    autocmd FileType mail,markdown setlocal wrap
    autocmd FileType mail,markdown setlocal spelllang=en,sk,de,cs

    " Spell-check Git messages
    autocmd FileType gitcommit setlocal spell
    autocmd FileType gitcommit setlocal spelllang=en

    " special settings for writing emails, flowed text at 72 width
    autocmd FileType mail setlocal textwidth=72
    autocmd FileType mail setlocal background=dark
    autocmd FileType mail setlocal comments+=nb:>
    autocmd FileType mail setlocal formatoptions+=awq
    autocmd FileType mail colorscheme hybrid

    " add the dash to keywords -- makes better css/js/html search
    " do this for specific files only (not in php/rb e.g.) where dashes are
    " not used in variable names (use camelCase instead here)
    autocmd BufNewFile,BufRead *.{js,css,scss,html} set iskeyword+=-
    autocmd BufNewFile,BufRead *.{js,css,scss,html} set iskeyword-=_
    autocmd BufNewFile,BufRead *.php set iskeyword-=-
    autocmd BufNewFile,BufRead neomutt-* set ft=mail

    " omnicompletion for some filetypes
    autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,php,twig setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType xml  setlocal ts=2 sts=2 sw=2 expandtab

    autocmd FileType sql  setlocal ts=2 sts=2 sw=2 expandtab

    au bufnewfile,bufread *.py 
        \ set tabstop=4 | 
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=79 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix 

    au bufread,bufnewfile *.c       set noexpandtab
    au bufread,bufnewfile *.h       set noexpandtab
    au bufread,bufnewfile makefile* set noexpandtab

    au bufread,bufnewfile *.conf setf dosini

    au focuslost * :wa
augroup END

" fix colors after setting colorscheme
autocmd BufNew,BufEnter *md colorscheme hybrid
autocmd BufNew,BufEnter * call lightline#enable() 
autocmd BufLeave *md colorscheme zellner

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" Keymaps {{{1

" tabs
nnoremap <C-t> :tabnew<cr>

" jk nice behaviour (screen lines vs. shown lines)
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" deactivate stupid ex-mode 
nnoremap Q <nop>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" command mode shortcuts to often used dirs
cnoremap %% <C-R>=fnameescape(expand("%:p:h")."/")<CR>

" enable folding with the spacebar
nnoremap <space> za             

" spellchecking 
nnoremap <leader>de :setlocal spell spelllang=de<cr>
nnoremap <leader>en :setlocal spell spelllang=en<cr>
nnoremap <leader>sk :setlocal spell spelllang=sk<cr>
nnoremap <leader>cz :setlocal spell spelllang=cz<cr>

nnoremap Q :qa!<cr>

" Leaders {{{1

" open new vertical split and change to split
nnoremap <leader>\| <C-w>v<C-w>l
nnoremap <leader>_ <C-w>s<C-w>j

" Find merge conflict markers
nnoremap <leader>gf /\v^[<\|=>]{7}( .*\|$)<CR>

" paste keeping indentation
nnoremap <leader>p p`[v`]=

nnoremap <leader>q :q!<cr>
"nnoremap <leader>t :term ++curwin<cr>
nnoremap <leader>t :terminal<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

nnoremap <leader>ve :e $MYVIMRC<cr>
nnoremap <expr><leader>tt ':e /martinuzak/work/prusa3d/tt_prusa_' . strftime('%Y-%m') . '.txt<CR>'
nnoremap <leader>td :e /martinuzak/todo.txt<CR>

" Opens an edit command with the path of the currently edited file filled in
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" insert mode mappings
inoremap <leader>D <C-r>=strftime('%Y-%m-%d')<cr>
inoremap <leader>d <C-r>=strftime('%Y-%m-%d %H:%M')<cr>
inoremap <leader>py import code; code.interact(local=dict(globals(), **locals()))<esc>

" Plugin Settings {{{1

" fugitive {{{2
nnoremap <silent> <leader>gs :G<CR><C-w>20+
nnoremap <silent> <leader>gd :Gvdiff<CR><C-w>20+
nnoremap <silent> <leader>gc :Gcommit<CR><C-w>20+
nnoremap <silent> <leader>gw :Gwrite<CR><C-w>20+
nnoremap <silent> <leader>gb :Gblame<CR><C-w>20+


" deoplete {{{2

" deoplete doesn't start up with normal gvim
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_smart_case=1
"let g:deoplete#auto_complete_delay=150
"
" try to fix too slow autocompletion
"let g:pymode_rope = 0
"

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert

set completeopt-=preview

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" jedi.vim {{{2
" disable autocompletion, cause we use deoplete for completion?
"let g:jedi#completions_enabled = 0

" open the go-to function in tab, not another buffer
"let g:jedi#use_tabs_not_buffers = 0

"let g:jedi#show_call_signatures = 0

" completion too slow?
"let g:pymode_rope = 0

" lightline {{{2
set noshowmode "no show mode because of lightline
"wombat, PaperClip, nord theme are nice too
let g:lightline = {
      \ 'colorscheme': 'nord', 
      \ 'active' : {
      \     'left' : [[ 'mode', 'paste' ],
      \               [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
      \ },
      \ 'component_function': {
      \      'gitbranch': 'FugitiveHead'
      \  }
      \ }

" fzf {{{2
nnoremap <leader>, :Files ~/
nnoremap <leader>. :Buffers<cr>
nnoremap <leader>rg :Rg<cr>
nnoremap <leader>l :Lines<cr>


" aperezdc/vim-template {{{2
let g:templates_directory='~/repos/dotfiles/.vim-templates'
let g:email='martin.uzak@gmail.com'
let g:username='Martin Užák'


" ale {{{2
let g:ale_set_highlights=0

let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=0
let g:ale_lint_on_enter=1
let g:ale_linters_explicit=1
let g:ale_fix_on_save=0
let g:ale_linters = {
  \ 'css': ['stylelint'],
  \ 'html': ['htmllint'],
  \ 'javascript': ['eslint'],
  \ 'javascriptreact': ['eslint'],
  \ 'json': ['jsonlint'],
  \ 'jsx': ['eslint'],
  \ 'php': ['php'],
  \ 'python': ['pylint'],
  \ 'scss': ['stylelint'],
  \ 'typescript': ['tslint'],
\}
let g:ale_fixers = {
  \ 'css': ['prettier'],
  \ 'javascript': ['prettier'],
  \ 'javascriptreact': ['prettier'],
  \ 'json': ['prettier'],
  \ 'jsx': ['prettier'],
  \ 'markdown': ['prettier'],
  \ 'python': ['black'],
  \ 'scss': ['prettier'],
  \ 'typescript': ['prettier'],
  \ 'yaml': ['prettier'],
\}


" vimwiki {{{2
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
"let g:vimwiki_ext2syntax = {'.wiki': 'markdown'}
let g:vimwiki_list = [{'path' : '/martinuzak/wiki', 'syntax' : 'markdown', 'ext' : '.md'}]

" vim-instant-markdown - Instant Markdown previews from Vim  {{{2
let g:instant_markdown_autostart = 0 " disable auto preview
map <leader>md :InstantMarkdownPreview<CR>

" vim-choosewin
nmap - <Plug>(choosewin)

" vim-easy-align {{{2
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}} vim: fdm=marker foldlevel=0
