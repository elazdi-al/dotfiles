-- Keymaps
local keymap = vim.keymap

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

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

-- LaTeX shortcuts (available in all buffers for quick access)
keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>", { desc = "LaTeX: Toggle compile" })
keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "LaTeX: View PDF" })
keymap.set("n", "<leader>lt", "<cmd>VimtexTocOpen<CR>", { desc = "LaTeX: Open TOC" })

-- Markdown shortcuts
keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown: Toggle preview" })
