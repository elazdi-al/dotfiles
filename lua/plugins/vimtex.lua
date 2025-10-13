return {
	"lervag/vimtex",
	lazy = false, -- lazy-loading will disable inverse search
	ft = { "tex", "latex" },
	config = function()
		-- Viewer settings (Skim for macOS)
		vim.g.vimtex_view_method = "skim"

		-- Compiler settings
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			build_dir = "",
			callback = 1,
			continuous = 1,
			executable = "latexmk",
			options = {
				"-pdf",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}

		-- Enable automatic compilation
		vim.g.vimtex_compiler_latexmk_engines = {
			_ = "-pdf",
		}

		-- Quickfix settings
		vim.g.vimtex_quickfix_mode = 0

		-- Disable overfull/underfull \hbox and all package warnings
		vim.g.vimtex_quickfix_ignore_filters = {
			"Overfull",
			"Underfull",
		}

		-- TOC settings
		vim.g.vimtex_toc_config = {
			name = "TOC",
			layers = { "content", "todo", "include" },
			split_width = 25,
			todo_sorted = 0,
			show_help = 1,
			show_numbers = 1,
		}

		-- Disable automatic concealment
		vim.g.vimtex_syntax_conceal_disable = 0

		-- Enable folding
		vim.g.vimtex_fold_enabled = 0

		-- Enable completion
		vim.g.vimtex_complete_enabled = 1

		-- Disable imaps (for better compatibility)
		vim.g.vimtex_imaps_enabled = 0

		-- Keybindings
		vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>", { desc = "Toggle continuous compilation" })
		vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View PDF" })
		vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocOpen<CR>", { desc = "Open TOC" })
		vim.keymap.set("n", "<leader>ll", "<cmd>VimtexClean<CR>", { desc = "Clean auxiliary files" })
		vim.keymap.set("n", "<leader>lL", "<cmd>VimtexCleanAll<CR>", { desc = "Clean all files" })
		vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "Show errors" })
		vim.keymap.set("n", "<leader>lo", "<cmd>VimtexCompileOutput<CR>", { desc = "Show compile output" })
	end,
}
