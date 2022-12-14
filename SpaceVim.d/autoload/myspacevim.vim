func! myspacevim#before() abort
  "other configs
  let g:github_dashboard = { 'username': 'nixboot', 'password': $GITHUB_TOKEN }
  let g:gista#client#default_username = 'monkeyxite'
  let g:startify_files_number = 20
endf

lua << EOF
  require("persistence").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

