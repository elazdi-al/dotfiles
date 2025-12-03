-- Core options
local opt = vim.opt
local g = vim.g

-- Leader keys (redundant safety, already set in init.lua)
g.mapleader = " "
g.maplocalleader = "\\"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.showmode = false

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance
opt.lazyredraw = false -- keep false for better UX
opt.synmaxcol = 240

-- Python environment
local venv_path = vim.fn.getcwd() .. "/venv/bin/python"
g.python3_host_prog = vim.fn.filereadable(venv_path) == 1 and venv_path or vim.fn.exepath("python3")
