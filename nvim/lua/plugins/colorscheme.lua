--return {
--  -- add gruvbox
--  { "ellisonleao/gruvbox.nvim" },
--
--  -- Configure LazyVim to load gruvbox
--  {
--    "LazyVim/LazyVim",
--    opts = {
--      colorscheme = "gruvbox",
--    },
--  }
--}

return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    -- you can do it like this with a config function
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        -- configurations
      })
    end,
    -- or just use opts table
    opts = {
      -- configurations
    },
  },
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
