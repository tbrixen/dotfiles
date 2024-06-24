return {
  "f-person/auto-dark-mode.nvim",
  init = function()
    vim.opt.background = "light"
  end,
  opts = {
    update_interval = 3000,
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
    end,
  },
}
