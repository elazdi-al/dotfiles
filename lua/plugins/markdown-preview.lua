return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		-- Browser settings
		vim.g.mkdp_auto_start = 0 -- Don't auto-open preview
		vim.g.mkdp_auto_close = 1 -- Auto-close preview when changing buffer
		vim.g.mkdp_refresh_slow = 0 -- Auto-refresh on save or leave insert mode
		vim.g.mkdp_command_for_global = 0 -- Only available in markdown files
		vim.g.mkdp_open_to_the_world = 0 -- Only accessible locally
		vim.g.mkdp_open_ip = ""
		vim.g.mkdp_browser = "" -- Use default browser
		vim.g.mkdp_echo_preview_url = 1 -- Echo preview URL
		vim.g.mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = 0,
			sync_scroll_type = "middle",
			hide_yaml_meta = 1,
			sequence_diagrams = {},
			flowchart_diagrams = {},
			content_editable = false,
			disable_filename = 0,
			toc = {},
		}

		-- Theme settings
		vim.g.mkdp_markdown_css = ""
		vim.g.mkdp_highlight_css = ""
		vim.g.mkdp_port = ""
		vim.g.mkdp_page_title = "「${name}」"

		-- Keybindings
		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })
	end,
}
