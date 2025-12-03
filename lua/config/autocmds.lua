-- Autocommands for file-specific settings and behavior

-- Create augroups
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Go settings and formatting
autocmd("FileType", {
	group = augroup("GoSettings", { clear = true }),
	pattern = "go",
	callback = function()
		-- Use tabs for Go (gofmt standard)
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})

autocmd("BufWritePre", {
	group = augroup("GoFormat", { clear = true }),
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Rust settings and formatting
autocmd("FileType", {
	group = augroup("RustSettings", { clear = true }),
	pattern = "rust",
	callback = function()
		-- Use spaces for Rust (rustfmt standard)
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.textwidth = 100
	end,
})

autocmd("BufWritePre", {
	group = augroup("RustFormat", { clear = true }),
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Suppress rust-analyzer workspace warnings for LeetCode standalone files
autocmd("LspAttach", {
	group = augroup("RustLeetCode", { clear = true }),
	pattern = "*.rs",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "rust_analyzer" then
			local file_path = vim.api.nvim_buf_get_name(args.buf)
			if file_path:match("leetcode") then
				vim.lsp.set_log_level("error")
			end
		end
	end,
})

-- Markdown settings
autocmd("FileType", {
	group = augroup("MarkdownSettings", { clear = true }),
	pattern = "markdown",
	callback = function()
		local opt = vim.opt_local
		local map = function(mode, keys, cmd, desc)
			vim.keymap.set(mode, keys, cmd, { buffer = true, desc = desc })
		end

		-- Text wrapping
		opt.wrap = true
		opt.linebreak = true
		opt.breakindent = true
		opt.conceallevel = 2

		-- Spell checking (disabled by default)
		opt.spell = false
		opt.spelllang = "en_us"

		-- Text formatting
		map("v", "<leader>mb", "c****<Esc>hPa", "Bold text")
		map("v", "<leader>mi", "c**<Esc>Pa", "Italic text")
		map("v", "<leader>mc", "c``<Esc>Pa", "Inline code")

		-- Insert elements
		map("n", "<leader>ml", "i[]()<Esc>F[a", "Insert link")
		map("n", "<leader>mx", "i- [ ] ", "Insert checkbox")

		-- Toggle checkbox
		map("n", "<leader>mt", function()
			local line = vim.api.nvim_get_current_line()
			if line:match("- %[ %]") then
				vim.api.nvim_set_current_line(line:gsub("- %[ %]", "- [x]", 1))
			elseif line:match("- %[x%]") then
				vim.api.nvim_set_current_line(line:gsub("- %[x%]", "- [ ]", 1))
			end
		end, "Toggle checkbox")

		-- Plugin toggles
		map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", "Toggle markdown preview")
		map("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", "Toggle markdown rendering")
		map("n", "<leader>ms", function()
			vim.opt_local.spell = not vim.opt_local.spell:get()
		end, "Toggle spell check")
	end,
})

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
	group = augroup("TrimWhitespace", { clear = true }),
	pattern = "*",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Auto-create directories when saving
autocmd("BufWritePre", {
	group = augroup("AutoCreateDir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
