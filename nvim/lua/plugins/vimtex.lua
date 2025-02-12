return {
    {
        "lervag/vimtex",
        ft = { "tex", "latex" }, -- Load only for LaTeX files
        config = function()
            -- Set Zathura as the default viewer
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_view_general_viewer = "zathura"
            vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

            -- Configure LaTeX compilation with latexmk
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                out_dir = "build", -- Store output in 'build' directory
                continuous = true, -- Auto compile on save
                callback = 1,
                executable = "latexmk",
                options = {
                    "-pdf",                     -- Generate PDF
                    "-interaction=nonstopmode", -- Keep running even on errors
                    "-synctex=1",               -- Enable SyncTeX for Zathura
                    "-shell-escape",            -- Enable shell escape for external tools
                    "-output-directory=build",  -- Output to 'build/' directory
                },
            }

            -- Enable forward search (from Neovim to Zathura)
            vim.g.vimtex_view_forward_search_on_start = 1

            -- Key mappings for easy compilation and PDF viewing
            vim.keymap.set("n", "<leader>lc", ":VimtexCompile<CR>", { silent = true }) -- Compile LaTeX
            vim.keymap.set("n", "<leader>lv", ":VimtexView<CR>", { silent = true })    -- Open PDF in Zathura
            vim.keymap.set("n", "<leader>lk", ":VimtexClean<CR>", { silent = true })   -- Clean build files
        end,
    },
}
