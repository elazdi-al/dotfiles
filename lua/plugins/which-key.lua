return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "+",
			},
			win = {
				border = "rounded",
				padding = { 2, 2, 2, 2 },
			},
		})

		-- Register leader key groups
		wk.add({
			{ "<leader>p", group = "Project/Paste" },
			{ "<leader>f", group = "Find" },
			{ "<leader>s", group = "Search" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>g", group = "Git" },
			{ "<leader>b", group = "Buffer" },
			{ "<leader>w", group = "Window" },
		})
	end,
}
