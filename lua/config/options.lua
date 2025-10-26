-- Options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = "menu,menuone,noselect"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Python environment
local venv_path = vim.fn.getcwd() .. "/venv/bin/python"
vim.g.python3_host_prog = vim.fn.filereadable(venv_path) == 1 and venv_path or vim.fn.exepath("python3")
