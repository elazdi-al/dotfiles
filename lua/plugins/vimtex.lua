return {
  "lervag/vimtex",
  ft = { "tex", "bib" },
  config = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "",
      continuous = 1,
      options = {
        "-pdf",
        "-interaction=nonstopmode",
        "-synctex=1",
        "-file-line-error",
      },
    }
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_quickfix_ignore_filters = { "Overfull", "Underfull" }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "tex", "bib" },
      callback = function()
        local map = function(keys, cmd, desc)
          vim.keymap.set("n", keys, cmd, { buffer = true, desc = desc })
        end
        map("<leader>lc", "<cmd>VimtexCompile<CR>", "Toggle compile")
        map("<leader>lv", "<cmd>VimtexView<CR>", "View PDF")
        map("<leader>lt", "<cmd>VimtexTocOpen<CR>", "Table of contents")
        map("<leader>le", "<cmd>VimtexErrors<CR>", "Show errors")
        map("<leader>ll", "<cmd>VimtexClean<CR>", "Clean aux files")
        map("<leader>lk", "<cmd>VimtexStop<CR>", "Stop compilation")
      end,
    })
  end,
}
