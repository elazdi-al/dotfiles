return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("render-markdown").setup({
      heading = {
        enabled = true,
        sign = false,
        icons = {},
      },
      code = {
        enabled = true,
        sign = false,
        style = "normal",
        width = "full",
      },
      bullet = {
        enabled = true,
        icons = { "•", "◦", "▪", "▫" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "[ ] " },
        checked = { icon = "[x] " },
      },
      quote = {
        enabled = true,
        icon = "│",
      },
    })
  end,
}
