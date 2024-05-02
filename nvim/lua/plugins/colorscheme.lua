return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
      flavour = "auto",
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      integrations = {
        which_key = false,
        leap = true,
        neotree = true,
        noice = true,
        lsp_trouble = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
        },
      })
    end,
  },
}
