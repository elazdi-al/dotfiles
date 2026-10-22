-- OPTIONS --
-- editor settings: display, indentation, search, file handling

-- DISPLAY --
vim.o.termguicolors = true    -- hex colors need truecolor support
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = 'yes'       -- prevent layout shift from diagnostics
vim.o.scrolloff = 8
vim.o.inccommand = 'split'     -- live substitution preview

-- INDENTATION --
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- SEARCH --
vim.o.ignorecase = true
vim.o.smartcase = true         -- case-sensitive when query has uppercase
vim.o.grepprg = 'rg --vimgrep --smart-case'
vim.o.grepformat = '%f:%l:%c:%m'

-- SPLITS --
vim.o.splitright = true
vim.o.splitbelow = true

-- FILE HANDLING --
vim.o.undofile = true          -- persistent undo across sessions
vim.o.swapfile = false

-- NETRW --
vim.g.netrw_list_hide = [[^\.]]
vim.g.netrw_hide = 1                 -- start with dotfiles hidden
-- press 'a' in netrw to cycle: all shown → dotfiles hidden → only dotfiles shown

-- PERFORMANCE --
vim.o.updatetime = 250         -- faster CursorHold (diagnostics, plugins)

-- GO BIN + MASON BIN ON PATH --
-- ~/go/bin first: repo-pinned tools (golangci-lint v1.64.8 per Makefile).
-- Mason appended last: provides gopls/gofumpt/go-debug-adapter.
-- /opt/homebrew/bin: typst/tinymist/typstyle for GUI-launched nvim (no shell PATH).
-- Explicit (not shell-dependent) so GUI-launched nvim resolves same binaries.
do
	local brew_bin = '/opt/homebrew/bin'
	if vim.uv.fs_stat(brew_bin) and not string.find(vim.env.PATH, brew_bin, 1, true) then
		vim.env.PATH = brew_bin .. ':' .. vim.env.PATH
	end
	local go_bin = vim.fn.expand('~/go/bin')
	if vim.uv.fs_stat(go_bin) and not string.find(vim.env.PATH, go_bin, 1, true) then
		vim.env.PATH = go_bin .. ':' .. vim.env.PATH
	end
	local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'
	if vim.uv.fs_stat(mason_bin) and not string.find(vim.env.PATH, mason_bin, 1, true) then
		vim.env.PATH = vim.env.PATH .. ':' .. mason_bin
	end
end

-- GO FILETYPE --
-- Go standard: tabs, not spaces. lll linter flags >120 cols.
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'go', 'gomod', 'gosum', 'gotmpl', 'gowork' },
	group = vim.api.nvim_create_augroup('user-go-opts', { clear = true }),
	callback = function()
		vim.bo.expandtab = false
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
		vim.wo.colorcolumn = '120'
	end,
})

-- CLIPBOARD --
vim.o.clipboard = 'unnamedplus'

-- TYPST FILETYPE --
-- typst convention: 2 spaces. wrap on for prose.
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'typst' },
	group = vim.api.nvim_create_augroup('user-typst-opts', { clear = true }),
	callback = function()
		vim.bo.expandtab = true
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
		vim.wo.wrap = true
		vim.wo.linebreak = true
	end,
})
