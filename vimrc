set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on    " Automatically detect file types

set termguicolors

set showcmd               " Display incomplete commands
set number
set showmode
set hidden                " See :h hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set laststatus=2
set relativenumber
set ruler                 " Displayer row and col

set encoding=utf-8

" Search
set ignorecase          " Ignore case 
set smartcase           " if I do search for somethin uppercase, use case
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp

" Clear the search highlight
nnoremap <CR> :noh<CR><CR>"

" Moving around bracket pairs by tab
nnoremap <tab> %
vnoremap <tab> %

" Make space the leader
map <SPACE> <leader>

noremap <C-c> <Esc>
inoremap jk <Esc>
nnoremap <leader>w <Esc>:w<CR>

noremap <C-J> :tabn<CR>
noremap <C-K> :tabp<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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

set ttimeout
set ttimeoutlen=50
set laststatus=2

" Enable jump between keywords
" [Niel] p 128
runtime macros/matchit.vim

" Tabs
set smartindent
set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.
set shiftwidth=2    " Indents will have a width of 2
set softtabstop=2   " Set the number of columns for at TAB
set expandtab       " Expand TABs to space

set colorcolumn=80

" Insert time
" Advanced use: strftime("%Y-%m-%d %a %H:%M %p")
nmap <F3> i<C-R>=strftime("%H:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%H:%M %p")<CR>


" Sets in-line spellchecking
" Guide: http://www.tjansson.dk/2008/10/writing-large-latex-documents-in-vim/
" UNCOMMENT for spellchecking
" Set local language 
setlocal spell spelllang=en_us
" setlocal spell spelllang=da
" set spell
set nospell


" Autofold
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

command Listcommands grep map $MYVIMRC

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" ========= Plugins ========= "
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
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
" }}}

" Buffergator ---------------------- {{{
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>
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
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" }}}

