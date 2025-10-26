return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_preview_options = {
      disable_sync_scroll = 0,
      sync_scroll_type = "middle",
      hide_yaml_meta = 1,
    }
  end,
}
