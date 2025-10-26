-- Keymaps
local keymap = vim.keymap

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Split management
keymap.set("n", "<leader>sv", ":vsplit<CR>", { silent = true, desc = "Vertical split" })
keymap.set("n", "<leader>sh", ":split<CR>", { silent = true, desc = "Horizontal split" })
keymap.set("n", "<leader>sc", ":close<CR>", { silent = true, desc = "Close split" })

-- Resize splits
keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true, desc = "Increase height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true, desc = "Decrease height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Increase width" })

-- Netrw file explorer
keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when scrolling
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Paste without yanking
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
