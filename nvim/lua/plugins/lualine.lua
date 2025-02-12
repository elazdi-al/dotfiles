return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "nordic", -- Change this based on your colorscheme ('auto', 'nordic', 'tokyonight', etc.)
        component_separators = { left = "│", right = "│" }, -- Slim vertical separators
        section_separators = { left = "", right = "" }, -- Powerline-style separators
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "TelescopePrompt" }, -- Hide lualine in these buffers
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { { "mode", fmt = string.upper } },  -- Uppercase mode (NORMAL, INSERT, etc.)
        lualine_b = { "branch", "diff", "diagnostics" }, -- Git info + diagnostics
        lualine_c = {
          {
            "filename",
            path = 1, -- Show relative path (0 = filename only, 1 = relative path, 2 = absolute path)
            symbols = {
              modified = " ●", -- Show ● when file is modified
              readonly = " ", -- Lock icon for readonly files
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" }, -- Show % of file read
        lualine_z = { "location" }, -- Show line:column
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "quickfix", "toggleterm" }, -- Enable for these plugins
    },
  },
}
