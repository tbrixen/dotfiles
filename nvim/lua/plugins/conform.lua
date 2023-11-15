return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local conform = require("conform")

      conform.formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-sr" },
        },
      }
      conform.formatters_by_ft = {
        tf = { "tfsec" },
        markdown = { "prettier" },
        json = { "prettier" },
        graphql = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
      }
    end,
  },
}
