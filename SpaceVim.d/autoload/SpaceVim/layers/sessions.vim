
"=============================================================================
" sessions.vim --- sessions Layer file for SpaceVim
" Copyright (c) 2012-2022 Shidong Wang & Contributors
" Author: Shidong Wang < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

""
" @section sessions, layers-sessions
" @parentsection layers
" This is the doc for this layer:
"
" @subsection Key Bindings
" >
"   Mode      Key           Function
"   -------------------------------------------------------------
"   normal    <leader>jA    generate accessors
"   normal    <leader>js    generate setter accessor
" <
" @subsection Layer options
" >
"   Name              Description                      Default
"   -------------------------------------------------------------
"   option1       Set option1 for sessions layer               ''
"   option2       Set option2 for sessions layer               []
"   option3       Set option3 for sessions layer               {}
" <
" @subsection Global options
" >
"   Name              Description                      Default
"   -------------------------------------------------------------
"   g:pluginA_opt1    Set opt1 for plugin A               ''
"   g:pluginB_opt2    Set opt2 for plugin B               []
" <

function! SpaceVim#layers#sessions#plugins() abort
  let plugins = []
  call add(plugins, ['folke/persistence.nvim', {'merged' : '0'}])
  return plugins
endfunction

function! SpaceVim#layers#sessions#config() abort
  "call SpaceVim#mapping#space#regesit_lang_mappings('sessions', function('s:language_specified_mappings'))
  "lua require("persistence").setup { }
  lua vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
endfunction

function! SpaceVim#layers#sessions#health() abort
  call SpaceVim#layers#sessions#plugins()
  call SpaceVim#layers#sessions#config()
  return 1
endfunction


"function! SpaceVim#layers#sessions#config() abort
"  let g:sessions_option1 = get(g:, 'sessions_option1', 1)
"  let g:sessions_option2 = get(g:, 'sessions_option2', 2)
"  let g:sessions_option3 = get(g:, 'sessions_option3', 3)
"  " ...
"endfunction
"
"" add layer options:
"let s:layer_option = 'default var'
"function! SpaceVim#layers#sessions#set_variable(var) abort
"  let s:layer_option = get(a:var, 'layer_option', s:layer_option)
"endfunction
"
"" completion function for layer options:
"function! SpaceVim#layers#sessions#get_options() abort
"    return ['layer_option']
"endfunction
"
