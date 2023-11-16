return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "tfsec")
    table.insert(opts.ensure_installed, "tflint")
    table.insert(opts.ensure_installed, "markdownlint")
  end,
}
