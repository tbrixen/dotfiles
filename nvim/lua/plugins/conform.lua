return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["json"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["javascript"] = { "prettier" },
        ["typescript"] = { "prettier" },
      },

      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-sr" },
        },
      },
    },
  },
}
