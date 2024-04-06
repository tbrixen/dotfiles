return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true },
      filetypes = {
        yaml = true,
      },
    })
  end,
}
