-- PLUGINS --
-- plugin installation via vim.pack and configuration

-- TMUX NAVIGATION --
-- seamless ctrl-h/j/k/l navigation between tmux panes and nvim splits
vim.pack.add({ { src = 'https://github.com/christoomey/vim-tmux-navigator' } })

-- THEME --
-- self-contained palette: every TS capture and LSP semantic token maps to one
-- of seven semantic colors. no base theme, no fallthrough.
do
	-- palette: kanagawa-dragon hues mapped to our semantic logic
	local p = {
		bg     = '#181616', -- dragonBlack3
		bg_alt = '#1f1d1d', -- between dragonBlack3 and dragonBlack4
		bg_sel = '#393836', -- dragonBlack5
		fg     = '#c5c9c5', -- dragonWhite — variables, identifiers, operators
		muted  = '#737c73', -- dragonAsh — comments
		dim    = '#625e5a', -- dragonBlack6 — punctuation, line numbers

		blue   = '#8ba4b0', -- dragonBlue2 — functions, methods
		gold   = '#c4b28a', -- dragonYellow — types, classes, constructors, namespaces
		green  = '#87a987', -- dragonGreen — strings, characters
		copper = '#b6927b', -- dragonOrange — constants, numbers, booleans, builtins
		violet = '#8992a7', -- dragonViolet — declaration/storage keywords (const, let, function, class, static, type)
		pink   = '#a292a3', -- dragonPink — control flow + module structure (if, return, for, import, try, async)
		red    = '#c4746e', -- dragonRed — errors only
		amber  = '#dca561', -- autumnYellow — warnings only
	}

	vim.cmd('hi clear')
	if vim.fn.exists('syntax_on') == 1 then vim.cmd('syntax reset') end
	vim.o.background = 'dark'
	vim.g.colors_name = 'softdark'

	local set = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end
	local fg = function(color, extra)
		local h = { fg = color }
		if extra then for k, v in pairs(extra) do h[k] = v end end
		return h
	end

	local groups = {
		-- editor UI
		Normal       = { fg = p.fg, bg = p.bg },
		NormalNC     = { fg = p.fg, bg = p.bg },
		NormalFloat  = { fg = p.fg, bg = p.bg_alt },
		FloatBorder  = { fg = p.dim, bg = p.bg_alt },
		FloatTitle   = { fg = p.gold, bg = p.bg_alt, bold = true },
		ColorColumn  = { bg = p.bg_alt },
		Conceal      = { fg = p.dim },
		Cursor       = { reverse = true },
		CursorLine   = { bg = p.bg_alt },
		CursorColumn = { bg = p.bg_alt },
		CursorLineNr = { fg = p.fg, bold = true },
		LineNr       = { fg = p.dim },
		SignColumn   = { bg = p.bg },
		FoldColumn   = { fg = p.dim, bg = p.bg },
		Folded       = { fg = p.muted, bg = p.bg_alt },
		EndOfBuffer  = { fg = p.bg },
		NonText      = { fg = p.dim },
		Whitespace   = { fg = p.dim },
		SpecialKey   = { fg = p.dim },
		MatchParen   = { fg = p.gold, bold = true, underline = true },
		VertSplit    = { fg = p.dim },
		WinSeparator = { fg = p.dim },
		Visual       = { bg = p.bg_sel },
		VisualNOS    = { bg = p.bg_sel },
		Search       = { fg = p.bg, bg = p.gold },
		IncSearch    = { fg = p.bg, bg = p.amber },
		CurSearch    = { fg = p.bg, bg = p.amber },
		Substitute   = { fg = p.bg, bg = p.violet },
		Pmenu        = { fg = p.fg, bg = p.bg_alt },
		PmenuSel     = { fg = p.fg, bg = p.bg_sel, bold = true },
		PmenuSbar    = { bg = p.bg_alt },
		PmenuThumb   = { bg = p.dim },
		StatusLine   = { fg = p.fg, bg = p.bg_alt },
		StatusLineNC = { fg = p.muted, bg = p.bg_alt },
		TabLine      = { fg = p.muted, bg = p.bg_alt },
		TabLineFill  = { bg = p.bg_alt },
		TabLineSel   = { fg = p.fg, bg = p.bg },
		WinBar       = { fg = p.fg, bg = p.bg },
		WinBarNC     = { fg = p.muted, bg = p.bg },
		Title        = { fg = p.gold, bold = true },
		Directory    = { fg = p.blue },
		ModeMsg      = { fg = p.fg },
		MoreMsg      = { fg = p.copper },
		MsgArea      = { fg = p.fg },
		Question     = { fg = p.copper },
		WarningMsg   = { fg = p.amber },
		ErrorMsg     = { fg = p.red },
		QuickFixLine = { bg = p.bg_sel },

		-- diff
		DiffAdd      = { bg = '#1f2a1f' },
		DiffChange   = { bg = '#2a2727' },
		DiffDelete   = { fg = p.red, bg = '#2e2020' },
		DiffText     = { bg = '#3a3535' },

		-- spell
		SpellBad     = { sp = p.red, undercurl = true },
		SpellCap     = { sp = p.amber, undercurl = true },
		SpellLocal   = { sp = p.copper, undercurl = true },
		SpellRare    = { sp = p.violet, undercurl = true },

		-- legacy syntax
		Comment        = fg(p.muted, { italic = true }),
		Constant       = fg(p.copper),
		String         = fg(p.green),
		Character      = fg(p.green),
		Number         = fg(p.copper),
		Boolean        = fg(p.copper),
		Float          = fg(p.copper),
		Identifier     = fg(p.fg),
		Function       = fg(p.blue),
		Statement      = fg(p.pink),
		Conditional    = fg(p.pink),
		Repeat         = fg(p.pink),
		Label          = fg(p.violet),
		Operator       = fg(p.fg),
		Keyword        = fg(p.violet),
		Exception      = fg(p.pink),
		PreProc        = fg(p.violet),
		Include        = fg(p.pink),
		Define         = fg(p.violet),
		Macro          = fg(p.violet),
		PreCondit      = fg(p.pink),
		Type           = fg(p.gold),
		StorageClass   = fg(p.violet),
		Structure      = fg(p.gold),
		Typedef        = fg(p.gold),
		Special        = fg(p.copper),
		SpecialChar    = fg(p.copper),
		Tag            = fg(p.gold),
		Delimiter      = fg(p.dim),
		SpecialComment = fg(p.muted, { italic = true, bold = true }),
		Debug          = fg(p.red),
		Underlined     = { fg = p.blue, underline = true },
		Ignore         = fg(p.dim),
		Error          = fg(p.red),
		Todo           = { fg = p.amber, bold = true },

		-- treesitter (modern captures)
		['@comment']                  = fg(p.muted, { italic = true }),
		['@comment.documentation']    = fg(p.muted, { italic = true }),
		['@comment.todo']             = { fg = p.amber, bold = true },
		['@comment.error']            = { fg = p.red, bold = true },
		['@comment.warning']          = { fg = p.amber, bold = true },
		['@comment.note']             = { fg = p.copper, bold = true },

		['@string']                   = fg(p.green),
		['@string.documentation']     = fg(p.green),
		['@string.regexp']            = fg(p.copper),
		['@string.escape']            = fg(p.copper),
		['@string.special']           = fg(p.copper),
		['@string.special.symbol']    = fg(p.copper),
		['@string.special.url']       = { fg = p.blue, underline = true },
		['@character']                = fg(p.green),
		['@character.special']        = fg(p.copper),

		['@number']                   = fg(p.copper),
		['@number.float']             = fg(p.copper),
		['@boolean']                  = fg(p.copper),
		['@float']                    = fg(p.copper),

		['@constant']                 = fg(p.copper),
		['@constant.builtin']         = fg(p.copper),
		['@constant.macro']           = fg(p.copper),

		['@function']                 = fg(p.blue),
		['@function.builtin']         = fg(p.blue),
		['@function.call']            = fg(p.blue),
		['@function.macro']           = fg(p.blue),
		['@function.method']          = fg(p.blue),
		['@function.method.call']     = fg(p.blue),
		['@method']                   = fg(p.blue),
		['@method.call']              = fg(p.blue),
		['@constructor']              = fg(p.gold),

		-- keyword split: violet = declaration/storage (function, class, const, let, static, type)
		--                pink   = control flow + module structure (if, return, for, import, try, async)
		['@keyword']                  = fg(p.violet),
		['@keyword.function']         = fg(p.violet),
		['@keyword.type']             = fg(p.violet),
		['@keyword.modifier']         = fg(p.violet),
		['@keyword.operator']         = fg(p.violet),
		['@keyword.directive']        = fg(p.violet),
		['@keyword.directive.define'] = fg(p.violet),
		['@keyword.coroutine']        = fg(p.pink),
		['@keyword.import']           = fg(p.pink),
		['@keyword.repeat']           = fg(p.pink),
		['@keyword.return']           = fg(p.pink),
		['@keyword.debug']            = fg(p.pink),
		['@keyword.exception']        = fg(p.pink),
		['@keyword.conditional']      = fg(p.pink),
		['@keyword.conditional.ternary'] = fg(p.pink),
		['@conditional']              = fg(p.pink),
		['@repeat']                   = fg(p.pink),
		['@exception']                = fg(p.pink),
		['@include']                  = fg(p.pink),
		['@storageclass']             = fg(p.violet),

		['@type']                     = fg(p.gold),
		['@type.builtin']             = fg(p.gold),
		['@type.definition']          = fg(p.gold),
		['@type.qualifier']           = fg(p.violet),
		['@attribute']                = fg(p.gold),
		['@property']                 = fg(p.fg),
		['@field']                    = fg(p.fg),

		['@variable']                 = fg(p.fg),
		['@variable.builtin']         = fg(p.copper),
		['@variable.parameter']       = fg(p.fg),
		['@variable.member']          = fg(p.fg),
		['@parameter']                = fg(p.fg),

		['@module']                   = fg(p.gold),
		['@module.builtin']           = fg(p.gold),
		['@namespace']                = fg(p.gold),
		['@symbol']                   = fg(p.copper),
		['@label']                    = fg(p.violet),

		['@operator']                 = fg(p.fg),
		['@punctuation']              = fg(p.dim),
		['@punctuation.delimiter']    = fg(p.dim),
		['@punctuation.bracket']      = fg(p.dim),
		['@punctuation.special']      = fg(p.copper),

		['@tag']                      = fg(p.violet),
		['@tag.builtin']              = fg(p.violet),
		['@tag.attribute']            = fg(p.gold),
		['@tag.delimiter']            = fg(p.dim),

		-- markup (markdown, etc.)
		['@markup.heading']           = { fg = p.gold, bold = true },
		['@markup.heading.1']         = { fg = p.gold, bold = true },
		['@markup.heading.2']         = { fg = p.gold, bold = true },
		['@markup.heading.3']         = { fg = p.blue, bold = true },
		['@markup.heading.4']         = { fg = p.blue, bold = true },
		['@markup.heading.5']         = { fg = p.copper, bold = true },
		['@markup.heading.6']         = { fg = p.copper, bold = true },
		['@markup.strong']            = { fg = p.fg, bold = true },
		['@markup.italic']            = { fg = p.fg, italic = true },
		['@markup.strikethrough']     = { fg = p.muted, strikethrough = true },
		['@markup.underline']         = { fg = p.fg, underline = true },
		['@markup.quote']             = fg(p.muted, { italic = true }),
		['@markup.math']              = fg(p.copper),
		['@markup.link']              = { fg = p.blue, underline = true },
		['@markup.link.label']        = fg(p.blue),
		['@markup.link.url']          = { fg = p.copper, underline = true },
		['@markup.raw']               = fg(p.green),
		['@markup.raw.block']         = fg(p.green),
		['@markup.list']              = fg(p.pink),
		['@markup.list.checked']      = fg(p.green),
		['@markup.list.unchecked']    = fg(p.muted),

		-- LSP semantic tokens (override TS — must be set explicitly)
		['@lsp.type.namespace']       = fg(p.gold),
		['@lsp.type.type']            = fg(p.gold),
		['@lsp.type.class']           = fg(p.gold),
		['@lsp.type.enum']            = fg(p.gold),
		['@lsp.type.interface']       = fg(p.gold),
		['@lsp.type.struct']          = fg(p.gold),
		['@lsp.type.typeParameter']   = fg(p.gold),
		-- cleared so treesitter's more specific captures win.
		-- without this, `myFunc()` is colored as @lsp.type.variable (fg) instead
		-- of @function.call (blue), because LSP tokens override TS by default.
		['@lsp.type.parameter']       = {},
		['@lsp.type.variable']        = {},
		['@lsp.type.property']        = {},
		['@lsp.type.member']          = {},
		['@lsp.type.selfKeyword']     = fg(p.violet),
		['@lsp.type.enumMember']      = fg(p.copper),
		['@lsp.type.event']           = fg(p.gold),
		['@lsp.type.function']        = fg(p.blue),
		['@lsp.type.method']          = fg(p.blue),
		['@lsp.type.macro']           = fg(p.violet),
		['@lsp.type.keyword']         = fg(p.violet),
		['@lsp.type.modifier']        = fg(p.violet),
		['@lsp.type.comment']         = fg(p.muted, { italic = true }),
		['@lsp.type.string']          = fg(p.green),
		['@lsp.type.number']          = fg(p.copper),
		['@lsp.type.regexp']          = fg(p.copper),
		['@lsp.type.operator']        = fg(p.fg),
		['@lsp.type.decorator']       = fg(p.gold),
		['@lsp.typemod.variable.readonly']       = fg(p.copper),
		['@lsp.typemod.variable.defaultLibrary'] = fg(p.copper),
		['@lsp.typemod.variable.global']         = fg(p.copper),
		['@lsp.typemod.variable.constant']       = fg(p.copper),
		['@lsp.typemod.function.defaultLibrary'] = fg(p.blue),
		['@lsp.typemod.function.builtin']        = fg(p.blue),
		['@lsp.typemod.method.defaultLibrary']   = fg(p.blue),
		['@lsp.typemod.method.builtin']          = fg(p.blue),
		['@lsp.typemod.method.static']           = fg(p.blue),
		['@lsp.typemod.member.defaultLibrary']   = fg(p.blue),
		['@lsp.typemod.member.builtin']          = fg(p.blue),
		['@lsp.typemod.type.defaultLibrary']     = fg(p.gold),
		['@lsp.typemod.type.builtin']            = fg(p.gold),
		['@lsp.typemod.class.defaultLibrary']    = fg(p.gold),
		['@lsp.typemod.class.builtin']           = fg(p.gold),
		['@lsp.typemod.keyword.controlFlow']     = fg(p.pink),

		-- pyright-specific token types (non-standard, but emitted)
		-- note: @lsp.type.member is cleared above so TS distinguishes methods
		-- (→ @function.method.call = blue) from fields (→ @variable.member = fg)
		['@lsp.type.intrinsic']         = fg(p.copper),
		['@lsp.type.magicFunction']     = fg(p.blue),
		['@lsp.type.builtinConstant']   = fg(p.copper),
		['@lsp.type.selfParameter']     = fg(p.copper),
		['@lsp.type.clsParameter']      = fg(p.copper),
		['@lsp.type.builtinAttribute']  = fg(p.fg),

		-- diagnostics
		DiagnosticError              = fg(p.red),
		DiagnosticWarn               = fg(p.amber),
		DiagnosticInfo               = fg(p.blue),
		DiagnosticHint               = fg(p.copper),
		DiagnosticOk                 = fg(p.green),
		DiagnosticVirtualTextError   = { fg = p.red, bg = p.bg },
		DiagnosticVirtualTextWarn    = { fg = p.amber, bg = p.bg },
		DiagnosticVirtualTextInfo    = { fg = p.blue, bg = p.bg },
		DiagnosticVirtualTextHint    = { fg = p.copper, bg = p.bg },
		DiagnosticUnderlineError     = { sp = p.red, undercurl = true },
		DiagnosticUnderlineWarn      = { sp = p.amber, undercurl = true },
		DiagnosticUnderlineInfo      = { sp = p.blue, undercurl = true },
		DiagnosticUnderlineHint      = { sp = p.copper, undercurl = true },

		-- LSP references
		LspReferenceText             = { bg = p.bg_sel },
		LspReferenceRead             = { bg = p.bg_sel },
		LspReferenceWrite            = { bg = p.bg_sel },

		-- gitsigns / signs
		GitSignsAdd                  = fg(p.green),
		GitSignsChange               = fg(p.amber),
		GitSignsDelete               = fg(p.red),

		-- telescope
		TelescopeNormal              = { fg = p.fg, bg = p.bg_alt },
		TelescopeBorder              = { fg = p.dim, bg = p.bg_alt },
		TelescopePromptNormal        = { fg = p.fg, bg = p.bg_alt },
		TelescopePromptBorder        = { fg = p.dim, bg = p.bg_alt },
		TelescopePromptTitle         = { fg = p.gold, bg = p.bg_alt, bold = true },
		TelescopeResultsTitle        = { fg = p.muted, bg = p.bg_alt },
		TelescopePreviewTitle        = { fg = p.muted, bg = p.bg_alt },
		TelescopeSelection           = { fg = p.fg, bg = p.bg_sel, bold = true },
		TelescopeMatching            = { fg = p.gold, bold = true },

		-- which-key
		WhichKey                     = fg(p.violet),
		WhichKeyGroup                = fg(p.gold),
		WhichKeyDesc                 = fg(p.fg),
		WhichKeySeparator            = fg(p.dim),
		WhichKeyFloat                = { bg = p.bg_alt },
	}

	for group, opts in pairs(groups) do set(group, opts) end
end

-- TELESCOPE --
vim.pack.add {
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
}
require('telescope').setup({
	defaults = {
		layout_strategy = 'bottom_pane',
		layout_config = { height = 0.25, prompt_position = 'bottom' },
		border = false,
		sorting_strategy = 'descending',
		results_title = false,
		prompt_title = false,
		preview_title = false,
	},
})

-- SNIPPETS --
-- UltiSnips: Gilles Castel's LaTeX snippet engine (requires python3 + pynvim)
vim.pack.add({ { src = 'https://github.com/SirVer/ultisnips' } })
vim.g.UltiSnipsExpandTrigger = '<Tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
vim.g.UltiSnipsSnippetDirectories = { 'UltiSnips' }

-- COMPLETION --
vim.pack.add {
	{ src = 'https://github.com/hrsh7th/nvim-cmp' },
	{ src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
}
local cmp = require('cmp')
cmp.setup({
	sources = { { name = 'nvim_lsp' } },
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})
-- completion item kind colors (kanagawa-dragon palette)
local kind_hl = {
	CmpItemAbbrMatch      = '#87a987', -- dragonGreen
	CmpItemAbbrMatchFuzzy = '#87a987', -- dragonGreen
	CmpItemKindFunction   = '#8ba4b0', -- dragonBlue2
	CmpItemKindMethod     = '#8ba4b0', -- dragonBlue2
	CmpItemKindVariable   = '#c5c9c5', -- dragonWhite
	CmpItemKindField      = '#c5c9c5', -- dragonWhite
	CmpItemKindKeyword    = '#8992a7', -- dragonViolet
	CmpItemKindProperty   = '#b6927b', -- dragonOrange
	CmpItemKindClass      = '#c4b28a', -- dragonYellow
	CmpItemKindInterface  = '#c4b28a', -- dragonYellow
	CmpItemKindModule     = '#c4b28a', -- dragonYellow
	CmpItemKindSnippet    = '#8992a7', -- dragonViolet
	CmpItemKindText       = '#737c73', -- dragonAsh
}
for group, color in pairs(kind_hl) do
	vim.api.nvim_set_hl(0, group, { fg = color })
end

-- TREESITTER --
-- first time: run :lua require('nvim-treesitter').install({ 'go', 'gomod', 'gosum', 'gotmpl', 'tsx', 'typescript', 'javascript', 'html', 'css', 'json', 'lua', 'python', 'c', 'markdown', 'markdown_inline', 'typst' })
vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter' } })

-- treesitter text objects: structural selection and movement (af, if, ac, ic, etc.)
vim.pack.add({ { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' } })

-- Start TS highlighting via Neovim's built-in API. We don't rely on
-- nvim-treesitter.configs.setup({ highlight = ... }) because that module is
-- being removed in nvim-treesitter's "main" branch rewrite, and its absence
-- silently disables highlighting. Starting TS directly works on either branch.
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('user-ts-highlight', { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if not lang then return end
		pcall(vim.treesitter.start, args.buf, lang)
		-- legacy regex syntax fights TS captures (e.g. pythonAttribute → fg white)
		vim.bo[args.buf].syntax = ''
	end,
})
-- catch buffers already loaded when this config sources (FileType won't refire)
for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
	if vim.api.nvim_buf_is_loaded(bufnr) then
		local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
		if lang then
			pcall(vim.treesitter.start, bufnr, lang)
			vim.bo[bufnr].syntax = ''
		end
	end
end

-- textobjects setup (this module still works on legacy nvim-treesitter; if the
-- pcall fails after migration to main branch, textobjects keymaps will need
-- to be reconfigured separately).
local ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
if ok then
	ts_configs.setup({
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					['af'] = { query = '@function.outer', desc = 'Around function' },
					['if'] = { query = '@function.inner', desc = 'Inside function' },
					['ac'] = { query = '@class.outer', desc = 'Around class' },
					['ic'] = { query = '@class.inner', desc = 'Inside class' },
					['aa'] = { query = '@parameter.outer', desc = 'Around argument' },
					['ia'] = { query = '@parameter.inner', desc = 'Inside argument' },
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					[']f'] = { query = '@function.outer', desc = 'Next function start' },
					[']c'] = { query = '@class.outer', desc = 'Next class start' },
					[']a'] = { query = '@parameter.outer', desc = 'Next argument start' },
				},
				goto_previous_start = {
					['[f'] = { query = '@function.outer', desc = 'Previous function start' },
					['[c'] = { query = '@class.outer', desc = 'Previous class start' },
					['[a'] = { query = '@parameter.outer', desc = 'Previous argument start' },
				},
			},
		},
	})
end

-- SURROUND --
-- sa (add), sd (delete), sr (replace) surrounding delimiters
vim.pack.add({ { src = 'https://github.com/echasnovski/mini.surround' } })
require('mini.surround').setup()

-- AUTOPAIRS --
-- auto-close {, (, [, $, etc. as you type
vim.pack.add({ { src = 'https://github.com/windwp/nvim-autopairs' } })
require('nvim-autopairs').setup()
cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

-- WHICH-KEY --
-- press <leader> and wait to see all available keybindings
vim.pack.add({ { src = 'https://github.com/folke/which-key.nvim' } })
require('which-key').setup()

-- LATEX --
vim.pack.add({ { src = 'https://github.com/lervag/vimtex' } })
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0

-- MASON --
vim.pack.add({ { src = 'https://github.com/williamboman/mason.nvim' } })
-- PATH='append': keep ~/go/bin (repo-pinned golangci-lint v1) ahead of
-- Mason's bin (golangci-lint v2, wrong config format). See options.lua.
require('mason').setup({ PATH = 'append' })

-- GO DEBUG (DAP) --
-- uses Mason's go-debug-adapter (delve backend). no extra `go install` needed.
-- run :DapInstallGoDeps once if delve missing, then <leader>db/<leader>dr to debug.
vim.pack.add({
	{ src = 'https://github.com/mfussenegger/nvim-dap' },
	{ src = 'https://github.com/leoluz/nvim-dap-go' },
})
pcall(function()
	require('dap-go').setup({
		dap_configurations = {
			{
				type = 'go',
				name = 'Debug package (race)',
				request = 'launch',
				program = '${fileDirname}',
				buildFlags = '-race',
			},
		},
	})
end)

-- SCALA --
vim.pack.add({ { src = 'https://github.com/scalameta/nvim-metals' } })

-- MARKDOWN --
-- clean minimal rendering: no sign-column icons, no full-width blocks
vim.pack.add({ { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' } })
require('render-markdown').setup({
	completions = { lsp = { enabled = true } },
	heading = { sign = false, width = 'block' },
	code = { sign = false, width = 'block', border = 'thin' },
	latex = { enabled = false },
})
