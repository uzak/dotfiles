" Setup {{{1

" inspired mostly by dotfiles of: `connermcd` and `webgefrickel`
 
language en_US.UTF-8
set nocompatible
syntax on
colorscheme zellner


" Plugins {{{1
"
call plug#begin("~/.vim/plugged") 

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
" also run: 
"   sudo apt install xdg-utils curl nodejs
"   npm -g install instant-markdown-d
 
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'aperezdc/vim-template'
Plug 'ap/vim-css-color'
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'w0ng/vim-hybrid'

call plug#end()


" Options {{{1

"set acd                  " auto change directory
"set list
let mapleader = ","
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set clipboard=unnamed      " use system clipboard
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
set listchars=extends:»,precedes:«,trail:·,tab:⇥\ ,eol:↵
set mouse=a
set nobackup
set nojoinspaces
set noswapfile
set path+=**            " https://www.youtube.com/watch?v=XA2WjJbmmoM
set scrolloff=3
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

" deactivate syntax highlighting when diffing
if &diff
  syntax off
endif

" OS specific {{{2

if has("win32")
    let skip_defaults_vim = 1
    set viminfo = ""
endif

if has("mac")
    set guifont=Inconsolata\ for\ Powerline:h14
elseif has("unix")
    set guifont=Monospace\ 12
elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
endif

" GUI options {{{2
if has("gui_running")
    set number
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
    autocmd FileType mail setlocal comments+=nb:>
    autocmd FileType mail setlocal formatoptions+=awq

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

autocmd BufNew,BufEnter *md colorscheme hybrid
" fix colors after setting colorscheme
autocmd BufNew,BufEnter * call lightline#enable() 
autocmd BufLeave *md colorscheme zellner

" Keymaps {{{1

" tabs
nnoremap tt :tabedit<space>
nnoremap t<Tab> :tabnext<CR>
nnoremap t<S-Tab> :tabprev<CR>
nnoremap <C-t> :tabnew<cr>

" jk nice behaviour (screen lines vs. shown lines)
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" deactivate stupid ex-mode 
nnoremap Q <nop>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" nnoremap Q :qa!<cr>

" command mode shortcuts to often used dirs
cnoremap %% <C-R>=fnameescape(expand("%:p:h")."/")<CR>

" enable folding with the spacebar
nnoremap <space> za             

" spellchecking 
nnoremap <leader>de :setlocal spell spelllang=de<cr>
nnoremap <leader>en :setlocal spell spelllang=en<cr>
nnoremap <leader>sk :setlocal spell spelllang=sk<cr>
nnoremap <leader>cz :setlocal spell spelllang=cz<cr>

" IDEA like search
nnoremap <S-f> :Files<CR>

" Leaders {{{1

" open new vertical split and change to split
nnoremap <leader>\ <C-w>v<C-w>l
nnoremap <leader>- <C-w>s<C-w>j

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
nnoremap <leader>p  :cd ~/repos/prusa<C-d>
nnoremap <leader>b  :cd /home/m/repos/blog/_posts/<CR>

" Opens an edit command with the path of the currently edited file filled in
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" insert mode mappings
inoremap <leader>D <C-r>=strftime('%Y-%m-%d')<cr>
inoremap <leader>d <C-r>=strftime('%Y-%m-%d %H:%M')<cr>
inoremap <leader>i import code; code.interact(local=dict(globals(), **locals()))<esc>

" Plugin Settings {{{1

" fugitive {{{2
nnoremap <silent> <leader>gs :G<CR><C-w>20+
nnoremap <silent> <leader>gd :Gvdiff<CR><C-w>20+
nnoremap <silent> <leader>gc :Gcommit<CR><C-w>20+
nnoremap <silent> <leader>gw :Gwrite<CR><C-w>20+
nnoremap <silent> <leader>gb :Gblame<CR><C-w>20+


" deoplete {{{2
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case=1
let g:deoplete#auto_complete_delay=150

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" jedi.vim {{{2
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in tab, not another buffer
let g:jedi#use_tabs_not_buffers = 1

let g:jedi#show_call_signatures = 0

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

" Neosnippet {{{2

let g:neosnippet#enable_completed_snippet = 1

imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

" fzf {{{2
nnoremap <leader>, :Files<cr>
nnoremap <leader>. :Buffers<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>a :Rg<cr>
nnoremap <leader>h :History:<cr>


"NERDtree {{{2
let g:NERDTreeIgnore = ['^__pycache__$']
nnoremap <C-n> :NERDTreeToggle<cr>

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
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>

" vim-easy-align {{{2
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"}}} vim: fdm=marker foldlevel=0
