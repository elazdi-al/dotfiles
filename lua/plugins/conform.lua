return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "markdownlint-cli2" },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				sh = { "shfmt" },
				go = { "gofmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
		end, { desc = "Format buffer/selection" })
	end,
}
