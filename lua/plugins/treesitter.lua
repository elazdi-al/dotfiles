return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "bash", "rust", "toml", "go", "gomod", "gosum", "html" },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
