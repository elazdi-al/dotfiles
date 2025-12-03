return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		arg = "leetcode.nvim",
		lang = "rust",
		cn = {
			enabled = false,
			translator = true,
			translate_problems = true,
		},
		storage = {
			home = vim.fn.expand("~/Desktop/leetcode"),
			cache = vim.fn.stdpath("cache") .. "/leetcode",
		},
		plugins = {
			non_standalone = false,
		},
		logging = true,
		injector = {},
		cache = {
			update_interval = 60 * 60 * 24 * 7,
		},
		editor = {
			reset_previous_code = true,
			fold_imports = true,
		},
		console = {
			open_on_runcode = true,
			dir = "row",
			size = {
				width = "90%",
				height = "75%",
			},
			result = {
				size = "60%",
			},
			testcase = {
				virt_text = true,
				size = "40%",
			},
		},
		description = {
			position = "left",
			width = "40%",
			show_stats = true,
		},
		picker = {
			provider = "telescope",
		},
		hooks = {
			["enter"] = {},
			["question_enter"] = {
				function(question)
					local file_name = question.title_slug .. ".rs"
					local cargo_path = vim.fn.expand("~/Desktop/leetcode/Cargo.toml")

					vim.defer_fn(function()
						local cargo_content = vim.fn.readfile(cargo_path)
						local bin_exists = false

						for _, line in ipairs(cargo_content) do
							if line:match('path = "' .. file_name .. '"') then
								bin_exists = true
								break
							end
						end

						if not bin_exists then
							local new_lines = {}
							local in_deps = false

							for i, line in ipairs(cargo_content) do
								table.insert(new_lines, line)

								if line:match("^edition") and not in_deps then
									table.insert(new_lines, "")
									table.insert(new_lines, "[[bin]]")
									table.insert(new_lines, 'name = "' .. question.title_slug .. '"')
									table.insert(new_lines, 'path = "' .. file_name .. '"')
									in_deps = true
								end
							end

							vim.fn.writefile(new_lines, cargo_path)
						end
					end, 100)
				end,
			},
			["leave"] = {},
		},
		keys = {
			toggle = { "q" },
			confirm = { "<CR>" },
			reset_testcases = "r",
			use_testcase = "U",
			focus_testcases = "H",
			focus_result = "L",
		},
		theme = {},
		image_support = false,
	},
}
