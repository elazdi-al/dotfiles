-- Go-specific configuration

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Go file settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		-- Use tabs for Go (gofmt standard)
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})
