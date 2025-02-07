--[[
  Custom plugin configuration for kickstart.nvim
  This file sets up the Nordic theme, LaTeX support, tmux navigation,
  a status line, and a file explorer.
  
  Place this file under your custom plugins directory so that lazy.nvim
  automatically picks it up.
--]]

return {
  -- ============================================================================
  -- LaTeX Support: VimTeX
  -- ============================================================================
  {
    'lervag/vimtex',
    ft = { 'tex', 'latex' }, -- Only load for LaTeX filetypes
    config = function()
      vim.g.vimtex_view_method = 'zathura' -- Set your preferred PDF viewer
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_quickfix_mode = 0 -- Disable quickfix mode if not needed
    end,
  },

  -- ============================================================================
  -- Status Line: Lualine
  -- ============================================================================
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'nord', -- Use the nord colorscheme for lualine
          section_separators = '',
          component_separators = '',
        },
      }
    end,
  },

  -- ============================================================================
  -- File Explorer: Nvim Tree
  -- ============================================================================
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = {
          width = 30,
          side = 'left',
        },
      }
      -- Toggle the file explorer with Ctrl+n
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  },

  -- ============================================================================
  -- TMUX Navigator: Seamlessly navigate between tmux panes and Neovim splits
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  -- ============================================================================
  -- Additional plugins can be added below
  -- ============================================================================
}
