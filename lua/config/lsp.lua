-- LSP Configuration for Neovim 0.11+

-- LSP Keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
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
    map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

    -- Diagnostics
    map("<leader>d", vim.diagnostic.open_float, "Show diagnostics")
    map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
  end,
})

-- Diagnostic Configuration
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

-- Diagnostic Signs
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Language Servers
-- Lua
vim.lsp.config("luals", {
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
})
vim.lsp.enable("luals")

-- Python
vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
})
vim.lsp.enable("pyright")

-- LaTeX (texlab provides better LSP features than vimtex alone)
vim.lsp.config("texlab", {
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
})
vim.lsp.enable("texlab")

-- Rust
vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				buildScripts = {
					enable = true,
				},
				-- Treat all .rs files in workspace as potential binaries
				extraEnv = { CARGO_TARGET_DIR = "target" },
			},
			checkOnSave = {
				enable = true,
				command = "check",
			},
			procMacro = {
				enable = true,
			},
			-- Enhanced completions
			completion = {
				autoimport = {
					enable = true,
				},
				autoself = {
					enable = true,
				},
			},
			inlayHints = {
				enable = true,
			},
			-- Support detached files (LeetCode individual solutions)
			files = {
				excludeDirs = { ".git" },
			},
			-- Enable standalone file support
			rustfmt = {
				extraArgs = { "+nightly" },
				overrideCommand = nil,
			},
		},
	},
})
vim.lsp.enable("rust_analyzer")

-- Uncomment to enable additional language servers:
-- TypeScript/JavaScript
-- vim.lsp.config("ts_ls", {
--   cmd = { "typescript-language-server", "--stdio" },
--   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
--   root_markers = { "package.json", "tsconfig.json", ".git" },
-- })
-- vim.lsp.enable("ts_ls")

-- Go
vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", ".git" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})
vim.lsp.enable("gopls")

-- Installation:
-- Lua:        brew install lua-language-server
-- Python:     npm install -g pyright
-- LaTeX:      brew install texlab
-- Rust:       brew install rust-analyzer
-- TypeScript: npm install -g typescript-language-server typescript
-- Go:         go install golang.org/x/tools/gopls@latest
