-- Rust-specific configuration

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Rust file settings
vim.api.nvim_create_autocmd("FileType", {
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

-- Suppress rust-analyzer workspace warnings for LeetCode standalone files
vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*.rs",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "rust_analyzer" then
			-- Check if this is a standalone file (no Cargo.toml nearby)
			local file_path = vim.api.nvim_buf_get_name(args.buf)
			if file_path:match("leetcode") then
				-- Reduce log level for this buffer to suppress warnings
				vim.lsp.set_log_level("error")
			end
		end
	end,
})
