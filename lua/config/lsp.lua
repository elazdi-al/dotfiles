-- LSP Configuration for Neovim 0.11+

-- LSP keybindings on attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
		end

		-- Navigation
		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gD", vim.lsp.buf.declaration, "Go to declaration")
		map("gi", vim.lsp.buf.implementation, "Go to implementation")
		map("gr", vim.lsp.buf.references, "Go to references")
		map("K", vim.lsp.buf.hover, "Hover documentation")

		-- Actions
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map("<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, "Format buffer")

		-- Diagnostics
		map("<leader>d", vim.diagnostic.open_float, "Show diagnostics")
		map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
		map("]d", vim.diagnostic.goto_next, "Next diagnostic")
	end,
})

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

-- Diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Language server configurations
local servers = {
	luals = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = { enable = false },
			},
		},
	},
	pyright = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
	},
	texlab = {
		cmd = { "texlab" },
		filetypes = { "tex", "bib" },
		root_markers = { ".latexmkrc", ".git" },
		settings = {
			texlab = {
				build = {
					executable = "latexmk",
					args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
					onSave = false,
					forwardSearchAfter = false,
				},
				forwardSearch = {
					executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
					args = { "%l", "%p", "%f" },
				},
				chktex = {
					onOpenAndSave = false,
					onEdit = false,
				},
			},
		},
	},
	rust_analyzer = {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		root_markers = { "Cargo.toml", ".git" },
		settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					buildScripts = { enable = true },
					extraEnv = { CARGO_TARGET_DIR = "target" },
				},
				checkOnSave = {
					enable = true,
					command = "check",
				},
				procMacro = { enable = true },
				completion = {
					autoimport = { enable = true },
					autoself = { enable = true },
				},
				inlayHints = { enable = true },
				files = { excludeDirs = { ".git" } },
				rustfmt = {
					extraArgs = { "+nightly" },
					overrideCommand = nil,
				},
			},
		},
	},
	gopls = {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.mod", ".git" },
		settings = {
			gopls = {
				analyses = { unusedparams = true },
				staticcheck = true,
				gofumpt = true,
			},
		},
	},
	-- Uncomment to enable TypeScript/JavaScript
	-- ts_ls = {
	-- 	cmd = { "typescript-language-server", "--stdio" },
	-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	-- 	root_markers = { "package.json", "tsconfig.json", ".git" },
	-- },
}

-- Enable all configured servers
for name, config in pairs(servers) do
	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

-- Installation guide (commented to avoid clutter)
-- Lua:        brew install lua-language-server
-- Python:     npm install -g pyright
-- LaTeX:      brew install texlab
-- Rust:       brew install rust-analyzer
-- Go:         go install golang.org/x/tools/gopls@latest
-- TypeScript: npm install -g typescript-language-server typescript
