" Convert to LUA. See https://neovim.io/doc/user/lua-guide.html#lua-guide ..
" init.vim and init.lua cannot coexist

function! myspacevim#before() abort
  "other configs
  let g:github_dashboard = { 'username': 'nixboot', 'password': $GITHUB_TOKEN }
  let g:gista#client#default_username = 'monkeyxite'
  let g:startify_files_number = 20
  let g:spacevim_sidebar_width           = 40
  let g:spacevim_relativenumber          = 1
  tnoremap <C-Esc> <C-\><C-n><C-w><C-w>
  tnoremap <S-Esc> <C-\><C-n>
endfunction

"func! myspacevim#after() abort
" lua vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
"endf

" doesnt work yet
"exe 'tnoremap <silent><esc>     <C-\><C-n>'
"exe 'tnoremap <silent><esc>     <C-\><C-n><C-w><C-w>'


