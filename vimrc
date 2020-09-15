" PLUGINS ---------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'aklt/plantuml-syntax'
Plug 'bling/vim-airline'
Plug 'bronson/vim-visual-star-search'
Plug 'christoomey/vim-tmux-navigator'
Plug 'connorholyday/vim-snazzy'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ervandew/supertab'
Plug 'iamcco/markdown-preview.nvim'
Plug 'jjaderberg/vim-ft-asciidoc'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mileszs/ack.vim'
Plug 'plasticboy/vim-markdown'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'robcsi/viewmaps.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'troydm/zoomwintab.vim'
Plug 'vim-scripts/groovyindent-unix'
Plug 'w0rp/ale'
if has('python3')
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif

call plug#end()

" }}}

" OPTIONS ---------------------- {{{
set nocompatible
set showcmd         " Display incomplete commands
set relativenumber  " Show line number relative to line of cursor
set number          " Show line number of cursor
set cursorline      " Highlight screen line of cursor
set hidden          " Don't prompt to save hidden windows
set wildmenu        " Show possible completion on command line
set wildmode=longest:list,full " 1. tab: ist all options 2. tab: complete to the longest common string
set laststatus=2    " Always show status line
set encoding=utf-8  " Make vim work in UTF-8
set list            " Show whitespace as special chars - see listchars
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " Unicode characters for various things

" Search
set ignorecase      " Case insensitive
set smartcase       " Override ignorecase, if searching for uppercase
set hlsearch        " Highlight searches
set incsearch       " While typing, show matches
set showmatch       " Briefly jump to matching bracket during insert

set ttyfast         " Improve smoothness, by redraw whole window for each char
set ttimeoutlen=50  " Only wait 50 ms to assume a :mapping is done

" Tabs
set smartindent     " Do automatic indent on c-like programs
set autoindent      " Copy indent when starting a new line
set expandtab       " In insert mode, use spaces when pressing <tab>
set tabstop=2       " Number of spaces a \t counts for 
set softtabstop=2   " Number of spaces a \t count for during editing
set shiftwidth=2    " Number of spaces for each step of (auto)indent

set colorcolumn=80

" If RipGrep is available, use it for grep
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" Enable jump between keywords
" [Niel] p 128
runtime macros/matchit.vim

filetype plugin indent on " Automatically detect file types
" }}}

" KEY MAPS ---------------------- {{{
" Make space the leader
map <SPACE> <leader>

" Clear the search highlight
nnoremap <CR> :noh<CR><CR>"

" Jump between bracket pairs by tab
nnoremap <tab> %
vnoremap <tab> %

" Maps to escape insert mode
noremap <C-c> <Esc>
inoremap jk <Esc>

" Save buffer using leader
nnoremap <leader>w :w<CR>
inoremap <leader>w <Esc>:w<CR>

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Marks should go to the column, not just the line. Why isn't this the default?
nnoremap ' `

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" Remove current buffer from buffer list without closing window
cnoremap bq  :bp <BAR> bd #<cr>
cnoremap bq! :bp <BAR> bd! #<cr>

" As default, don't :find in /usr/include
set path-=/usr/include

" Edit and find recursively
set wildcharm=<C-z>
nnoremap ,e :e **/*<C-z><S-Tab>
nnoremap ,f :find **/*<C-z><S-Tab>

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" }}}

" COLORS ---------------------- {{{
silent! colorscheme snazzy

syntax enable
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" }}}

" CUSTOM COMMANDS AND FUNCTIONS ---------------------- {{{
" Insert time
" Advanced use: strftime("%Y-%m-%d %a %H:%M %p")
nmap <F3> i<C-R>=strftime("%H:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%H:%M %p")<CR>
nmap <F12> <ESC>:w <bar> execute 'silent !\%USERPROFILE\%\Documents\Noter\journal\update.bat' <bar> e <bar> normal zo<CR>
imap <F12> <ESC>:w <bar> execute 'silent !\%USERPROFILE\%\Documents\Noter\journal\update.bat' <bar> e <bar> normal zo<CR>

" }}}

" FILE TYPE TRIGGERS ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

autocmd BufNewFile,BufRead *.json set ft=javascript

" If filetype contains <project name, it should be considered as an Ant script
autocmd BufNewFile,BufRead *.xml if search('<project name', 'nw') | set ft=ant | endif

autocmd syntax groovy,Jenkinsfile setlocal foldmethod=indent | setlocal foldlevel=1
autocmd syntax ant setlocal foldmethod=indent | setlocal foldlevel=1

" }}}

" PLUGINS SETTINGS ---------------------- {{{

" Markdown ---------------------- {{{
nnoremap <Leader>pp :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
nnoremap <Leader>pv :RunSilent open /tmp/vim-pandoc-out.pdf<CR>

let g:vim_markdown_folding_level=2
let g:vim_markdown_autowrite = 1
" Enable latex math highlight
let g:vim_markdown_math=1
" }}}

" Markdown-preview.nvim ---------------------- {{{

" Don't close browser windows when changing buffer
let g:mkdp_auto_close = 0
" }}}

" Vim-airline---------------------- {{{
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" PyMode ---------------------- {{{
let g:pymode_lint = 0
" }}}

" CtrlP ---------------------- {{{
let g:ctrlp_working_path_mode = 'r'
" Easy bindings for its various modes
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nmap <leader>o :CtrlPBuffer<cr>
" Don't jump to viewport with buffer, but use corrent viewport
" This helps to restore splits on the same buffer
let g:ctrlp_switch_buffer = 0
" }}}

" vim-easy-align ---------------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" git-gutter ---------------------- {{{
nmap <leader>ghn <Plug>(GitGutterNextHunk)
nmap <leader>ghp <Plug>(GitGutterPrevHunk)
nmap <Leader>ghv <Plug>(GitGutterPreviewHunk)
nmap <Leader>ghu <Plug>(GitGutterUndoHunk)
set updatetime=100
" }}}

" vim-unimparied ---------------------- {{{
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]
" }}}

" fzf ---------------------- {{{
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
nmap <leader>ll :Lines<cr>
" }}}

" tagbar ---------------------- {{{
nmap <F7> :TagbarToggle<CR>
" }}}

" Ack ---------------------- {{{
" Tell ack.vim to use ripgrep instead
let g:ackprg = 'rg --vimgrep --no-heading'
" }}}

" Vim-rooter ---------------------- {{{
let g:rooter_patterns = ['vimrooter', '.git/']
" }}}

" ale ---------------------- {{{
let g:ale_linters = {
\   'sh': ['shellcheck'],
\   'Dockerfile': ['hadolint'],
\}
" }}}

" vim-json ---------------------- {{{
" workaround needed when you use elzr/vim-json with indentLine
" https://github.com/elzr/vim-json/issues/23
let g:indentLine_noConcealCursor=""
" }}}

" vim-tmux-navigator ---------------------- {{{
"let g:tmux_navigator_no_mappings = 1

" See https://stackoverflow.com/questions/9520676/macvim-iterm2-tmux-bind-alt-meta
execute "set <A-j>=\ej"
execute "set <A-k>=\ek"
execute "set <A-h>=\eh"
execute "set <A-l>=\el"
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
" }}}

" ViewMap ---------------------- {{{
nnoremap <silent> <leader>dn :ViewMaps n quickfix<CR> "display normal mode maps
nnoremap <silent> <leader>di :ViewMaps i quickfix<CR> "display insert mode maps
nnoremap <silent> <leader>dv :ViewMaps v quickfix<CR> "display visual mode maps
" }}}


" }}}

