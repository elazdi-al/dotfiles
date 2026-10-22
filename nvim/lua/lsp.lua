-- LSP CONFIG --
-- language servers and diagnostics

vim.pack.add({ { src = 'https://github.com/neovim/nvim-lspconfig' } })

-- cmp-nvim-lsp capabilities for all servers
vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- lua_ls: recognize 'vim' global for neovim configs
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = { globals = { 'vim' } },
		},
	},
})
vim.lsp.enable('lua_ls')

-- pyright: auto-detect a project-local virtualenv (.venv or venv) and point
-- pyright at its interpreter via settings.python.pythonPath. without this,
-- pyright uses the system python and can't see venv-installed packages, so
-- type resolution silently fails (and consequently TS captures fall back to
-- @variable.member = fg, which renders white on method calls).
vim.lsp.config('pyright', {
	before_init = function(_, config)
		local root = config.root_dir
		if not root then return end
		for _, rel in ipairs({ '/.venv/bin/python', '/venv/bin/python', '/.venv/bin/python3' }) do
			local py = root .. rel
			if vim.uv.fs_stat(py) then
				config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
					python = { pythonPath = py },
				})
				return
			end
		end
	end,
})
vim.lsp.enable('pyright')

-- ts_ls: ts/tsx/js/jsx, recognizes bun.lockb
vim.lsp.config('ts_ls', {
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
	root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', 'bun.lockb', '.git' },
})
vim.lsp.enable('ts_ls')

-- tailwindcss
vim.lsp.config('tailwindcss', {
	filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
	root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.mjs', '.git' },
})
vim.lsp.enable('tailwindcss')

-- gopls: clean Go (gofumpt + staticcheck + unimported completion)
-- Mason already provides gopls/gofumpt; PATH fix lives in options.lua.
-- golangci-lint stays as :! command (see keymaps <leader>gl), not as
-- second LSP, to avoid duplicate diagnostics with gopls.
vim.lsp.config('gopls', {
	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_markers = { 'go.work', 'go.mod', '.git' },
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			completeUnimported = true,
			usePlaceholders = true,
			semanticTokens = true,
			directoryFilters = { '-.git', '-.vscode', '-.idea', '-node_modules' },
			codelenses = {
				gc_details = true,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				fieldalignment = false, -- too strict, matches .golangci.yml govet disable
				nilness = true,
				shadow = false, -- too many false positives, matches .golangci.yml
				unusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			vulncheck = 'Imports',
		},
	},
})
vim.lsp.enable('gopls')

-- Go: organize imports + gofumpt-format on save via gopls only.
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*.go',
	group = vim.api.nvim_create_augroup('user-go-imports', { clear = true }),
	callback = function()
		local params = vim.lsp.util.make_range_params(0, 'utf-8')
		params.context = { only = { 'source.organizeImports' } }
		local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1000)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-8'
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				elseif r.command then
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end,
})

-- clangd
vim.lsp.enable('clangd')

-- texlab
vim.lsp.enable('texlab')

-- tinymist: typst LSP + formatter + live browser preview (`tinymist preview`)
vim.lsp.config('tinymist', {
	cmd = { 'tinymist' },
	filetypes = { 'typst' },
	root_markers = { '.git' },
	settings = {
		formatterMode = 'typstyle',
		exportPdf = 'onSave',
		semanticTokens = 'enable',
	},
})
vim.lsp.enable('tinymist')

-- Typst: format on save via tinymist (typstyle).
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*.typ',
	group = vim.api.nvim_create_augroup('user-typst-format', { clear = true }),
	callback = function() vim.lsp.buf.format({ async = false }) end,
})

-- metals: scala/sbt/java
local metals = require('metals').bare_config()
metals.capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'scala', 'sbt', 'java' },
	group = vim.api.nvim_create_augroup('nvim-metals', { clear = true }),
	callback = function() require('metals').initialize_or_attach(metals) end,
})

-- DIAGNOSTICS --
vim.diagnostic.config({
	signs = false,
	virtual_text = { spacing = 2 },
})
