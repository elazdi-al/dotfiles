-- KEYMAPS --
-- all keybindings in one place, grouped by category
-- neovim 0.11+ built-in LSP defaults: K grn gra grr gri [d ]d

-- GENERAL --
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Save and source current file' })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open file explorer' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- NAVIGATION --
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up (centered)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search match (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search match (centered)' })

-- MOVING LINES --
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- TELESCOPE --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep across project' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search open buffers' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find diagnostics' })

-- LSP --
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format buffer' })

-- DIAGNOSTICS --
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic message' })
local warnings_visible = true
vim.keymap.set('n', '<leader>tw', function()
	warnings_visible = not warnings_visible
	vim.diagnostic.config({
		signs = false,
		virtual_text = warnings_visible
		    and { spacing = 2 }
		    or { spacing = 2, severity = { min = vim.diagnostic.severity.ERROR } },
	})
end, { desc = 'Toggle warning diagnostics' })

-- QUICKFIX --
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Previous quickfix item' })

-- GO --
-- match Makefile: `make vet` = go vet ./..., `make lint` = golangci-lint run
vim.keymap.set('n', '<leader>gb', '<cmd>!go build ./...<CR>', { desc = 'Go build all' })
vim.keymap.set('n', '<leader>gt', '<cmd>!go test ./...<CR>', { desc = 'Go test all' })
vim.keymap.set('n', '<leader>gtr', '<cmd>!go test -race -count=1 ./...<CR>', { desc = 'Go test with race' })
vim.keymap.set('n', '<leader>gv', '<cmd>!go vet ./...<CR>', { desc = 'Go vet' })
vim.keymap.set('n', '<leader>gl', '<cmd>!golangci-lint run ./...<CR>', { desc = 'golangci-lint run' })
vim.keymap.set('n', '<leader>gm', '<cmd>!go mod tidy<CR>', { desc = 'Go mod tidy' })
vim.keymap.set('n', '<leader>th', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })

-- DAP (Go via delve) --
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'DAP toggle breakpoint' })
vim.keymap.set('n', '<leader>dr', function() require('dap').continue() end, { desc = 'DAP continue/run' })
vim.keymap.set('n', '<leader>do', function() require('dap').step_over() end, { desc = 'DAP step over' })
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'DAP step into' })
vim.keymap.set('n', '<leader>dO', function() require('dap').step_out() end, { desc = 'DAP step out' })
vim.keymap.set('n', '<leader>dt', function() require('dap-go').debug_test() end, { desc = 'DAP debug nearest Go test' })
vim.keymap.set('n', '<leader>dx', function() require('dap').terminate() end, { desc = 'DAP terminate' })
vim.keymap.set('n', '<leader>du', function() require('dap').repl.open() end, { desc = 'DAP open REPL' })

-- LATEX --
vim.keymap.set('n', '<leader>lc', '<cmd>VimtexCompile<CR>', { desc = 'Compile LaTeX document' })
vim.keymap.set('n', '<leader>lv', '<cmd>VimtexView<CR>', { desc = 'View PDF in zathura' })

-- TYPST --
-- <leader>tp: live browser preview via tinymist (auto-reloads on save).
-- <leader>tq: stop preview. <leader>tc: one-shot PDF compile. <leader>to: open PDF.
vim.keymap.set('n', '<leader>tp', function()
	if vim.g.typst_preview_job then
		vim.fn.jobstop(vim.g.typst_preview_job)
		vim.g.typst_preview_job = nil
	end
	local file = vim.fn.expand('%:p')
	if vim.fn.expand('%:e') ~= 'typ' then
		vim.notify('not a typst file', vim.log.levels.WARN)
		return
	end
	vim.g.typst_preview_job = vim.fn.jobstart({ 'tinymist', 'preview', file, '--open' }, { detach = true })
	vim.notify('typst preview started (<leader>tq to stop)', vim.log.levels.INFO)
end, { desc = 'Typst live browser preview' })
vim.keymap.set('n', '<leader>tq', function()
	if vim.g.typst_preview_job then
		vim.fn.jobstop(vim.g.typst_preview_job)
		vim.g.typst_preview_job = nil
		vim.notify('typst preview stopped', vim.log.levels.INFO)
	else
		vim.notify('no typst preview running', vim.log.levels.WARN)
	end
end, { desc = 'Stop typst preview' })
vim.keymap.set('n', '<leader>tc', '<cmd>!typst compile % %:r.pdf<CR>', { desc = 'Typst compile to PDF' })
vim.keymap.set('n', '<leader>to', '<cmd>!open %:r.pdf &<CR>', { desc = 'Open typst PDF' })

-- MARKDOWN --
vim.keymap.set('n', '<leader>tm', function() require('render-markdown').toggle() end, { desc = 'Toggle markdown render' })

-- THEME DEBUG --
-- :HlAt — at cursor, lists every TS capture, LSP semantic token, and syntax
-- group with its resolved fg color, flagging entries that render as fg-white
-- (#c5c9c5). use this when something looks wrong: the topmost flagged group
-- is the one winning and producing the wrong color.
vim.api.nvim_create_user_command('HlAt', function()
	local FG_WHITE = 'c5c9c5'
	local items = vim.inspect_pos()

	local function resolve(group)
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		if hl.fg then return string.format('%06x', hl.fg) end
		-- empty hl group (e.g. cleared @lsp.type.variable) → falls through to Normal
		return nil
	end

	local function fmt(group)
		local fg = resolve(group)
		if not fg then
			return string.format('  %-50s fg=(unset → falls through)', group)
		end
		local mark = (fg == FG_WHITE) and '   ← WHITE' or ''
		return string.format('  %-50s fg=#%s%s', group, fg, mark)
	end

	local lines = { string.format('hl groups at %d:%d (priority: last wins)',
		vim.fn.line('.'), vim.fn.col('.')) }

	if #items.treesitter > 0 then
		table.insert(lines, '── treesitter ──')
		for _, item in ipairs(items.treesitter) do
			table.insert(lines, fmt(item.hl_group))
		end
	end

	if #items.semantic_tokens > 0 then
		table.insert(lines, '── lsp semantic tokens ──')
		for _, item in ipairs(items.semantic_tokens) do
			table.insert(lines, fmt(item.opts.hl_group))
		end
	end

	if #items.syntax > 0 then
		table.insert(lines, '── syntax (legacy) ──')
		for _, item in ipairs(items.syntax) do
			table.insert(lines, fmt(item.hl_group))
		end
	end

	vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
end, { desc = 'Show hl groups at cursor and flag white-rendering ones' })

vim.keymap.set('n', '<leader>hi', '<cmd>HlAt<CR>', { desc = 'Inspect hl groups at cursor' })

