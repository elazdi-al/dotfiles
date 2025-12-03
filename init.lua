-- Set leader keys before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.lazy")

-- Load LSP configuration (for Neovim 0.11+)
require("config.lsp")

-- Load language-specific configurations
require("config.rust")
require("config.golang")

-- Load markdown configuration
require("config.markdown")
