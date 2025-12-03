return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"go",
				"gomod",
				"gosum",
				"html",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"rust",
				"toml",
				"vim",
				"vimdoc",
			},
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}
