"=============================================================================
" terraform.vim --- terraform Layer file for SpaceVim
" Copyright (c) 2012-2022 Shidong Wang & Contributors
" Author: Shidong Wang < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

""
" @section terraform, layers-terraform
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
"   option1       Set option1 for terraform layer               ''
"   option2       Set option2 for terraform layer               []
"   option3       Set option3 for terraform layer               {}
" <
" @subsection Global options
" >
"   Name              Description                      Default
"   -------------------------------------------------------------
"   g:pluginA_opt1    Set opt1 for plugin A               ''
"   g:pluginB_opt2    Set opt2 for plugin B               []
" <

function! SpaceVim#layers#lang#terraform#plugins() abort
  let plugins = []
  " vim-terraform: sets up mapping from misc .tf files to be highlighed as HCL
  call add(plugins, ['hashivim/vim-terraform', {'merged' : '0'}])
  return plugins
endfunction

function! SpaceVim#layers#lang#terraform#config() abort
  "call SpaceVim#mapping#space#regesit_lang_mappings('terraform', function('s:language_specified_mappings'))
endfunction

function! SpaceVim#layers#lang#terraform#health() abort
  call SpaceVim#layers#lang#terraform#plugins()
  call SpaceVim#layers#lang#terraform#config()
  return 1
endfunction

"function! SpaceVim#layers#terraform#config() abort
"  let g:terraform_option1 = get(g:, 'terraform_option1', 1)
"  let g:terraform_option2 = get(g:, 'terraform_option2', 2)
"  let g:terraform_option3 = get(g:, 'terraform_option3', 3)
"  " ...
"endfunction
"
"" add layer options:
"let s:layer_option = 'default var'
"function! SpaceVim#layers#terraform#set_variable(var) abort
"  let s:layer_option = get(a:var, 'layer_option', s:layer_option)
"endfunction
"
"" completion function for layer options:
"function! SpaceVim#layers#terraform#get_options() abort
"    return ['layer_option']
"endfunction
"
