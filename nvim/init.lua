-- INIT --
-- entry point: set leader key first, then load modules in order

-- set leader key to space (must be set before keymaps)
vim.g.mapleader = " "

-- load config modules
require('options')  -- editor settings
require('plugins')  -- plugin installation and configuration
require('lsp')      -- language servers and diagnostics
require('keymaps')  -- all keybindings

-- BEGIN CTF NOTES
package.loaded.ctf = dofile('/Users/admin/Desktop/ctf-learning/setup/nvim/lua/ctf.lua')
-- END CTF NOTES
