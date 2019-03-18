runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" OPTIONS ---------------------- {{{
set nocompatible
set showcmd         " Display incomplete commands
set relativenumber  " Show line number relative to line of cursor
set number          " Show line number of cursor
set cursorline      " Highlight screen line of cursor
set hidden          " Don't prompt to save hidden windows
set wildmenu        " Show possible completion on command line
set wildmode=list:longest " List all options, and complete with the most common
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
nnoremap <leader>w <Esc>:w<CR>

" Move between tabs
noremap <C-J> :tabn<CR>
noremap <C-K> :tabp<CR>

" Marks should go to the column, not just the line. Why isn't this the default?
nnoremap ' `

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Remove current buffer from buffer list
nmap <leader>bq :bp <BAR> bd #<cr>

" }}}

" COLORS ---------------------- {{{
silent! colorscheme molokayo

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

command Listcommands grep map $MYVIMRC
" }}}

" FILE TYPE TRIGGERS ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" PLUGINS SETTINGS ---------------------- {{{

" Markdown ---------------------- {{{
autocmd BufRead,BufNewFile *.md set filetype=markdown 
nnoremap <Leader>pp :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
nnoremap <Leader>pv :RunSilent open /tmp/vim-pandoc-out.pdf<CR>

" Disable folding of sections
let g:vim_markdown_folding_disabled=1
" Enable latex math highlight
let g:vim_markdown_math=1
" }}}

" Vim-airline---------------------- {{{
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" YouCompleteMe ---------------------- {{{
" Only do autocomplete in the following files
let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1, 'python':1, 'java':1 }

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

" PyMode ---------------------- {{{
let g:pymode_lint = 0
" }}}

" CtrlP ---------------------- {{{
let g:ctrlp_working_path_mode = 'r'
" Easy bindings for its various modes
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
" }}}

" vim-easy-align ---------------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" git-gutter ---------------------- {{{
nmap <C-L> <Plug>GitGutterNextHunk
nmap <C-H> <Plug>GitGutterPrevHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk
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
nmap <leader>bb :Buffers<cr>
nmap <leader>ff :Files<cr>
nmap <leader>ll :Lines<cr>
" }}}

" tagbar ---------------------- {{{
nmap <F7> :TagbarToggle<CR>
" }}}

" }}}

