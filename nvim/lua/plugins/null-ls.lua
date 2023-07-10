return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")

      opts.sources = {
        null_ls.builtins.formatting.shfmt.with({
          args = { "-i", "2", "-sr" }, -- https://github.com/mvdan/sh/blob/master/cmd/shfmt/shfmt.1.scd
        }),
      }
      if type(opts.sources) == "table" then
        vim.list_extend(opts.sources, {
          null_ls.builtins.diagnostics.tfsec,
        })
      end
    end,
  },
}
