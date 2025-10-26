return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      icons = { group = "+" },
      win = { border = "rounded" },
    })
    wk.add({
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LaTeX/LSP" },
      { "<leader>m", group = "Markdown" },
      { "<leader>c", group = "Code" },
      { "<leader>s", group = "Split" },
    })
  end,
}
