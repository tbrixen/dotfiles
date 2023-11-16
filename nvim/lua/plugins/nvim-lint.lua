return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        terraform = { "terraform_validate", "tfsec" },
        tf = { "terraform_validate", "tfsec" },
        markdown = { "markdownlint" },
      },
    },
  },
}
