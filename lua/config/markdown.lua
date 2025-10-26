-- Markdown configuration
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true }),
  pattern = "markdown",
  callback = function()
    local opt = vim.opt_local
    local map = function(mode, keys, cmd, desc)
      vim.keymap.set(mode, keys, cmd, { buffer = true, desc = desc })
    end

    -- Text wrapping
    opt.wrap = true
    opt.linebreak = true
    opt.breakindent = true
    opt.conceallevel = 2

    -- Spell checking (disabled by default)
    opt.spell = false
    opt.spelllang = "en_us"

    -- Text formatting
    map("v", "<leader>mb", "c****<Esc>hPa", "Bold text")
    map("v", "<leader>mi", "c**<Esc>Pa", "Italic text")
    map("v", "<leader>mc", "c``<Esc>Pa", "Inline code")

    -- Insert elements
    map("n", "<leader>ml", "i[]()<Esc>F[a", "Insert link")
    map("n", "<leader>mx", "i- [ ] ", "Insert checkbox")

    -- Toggle checkbox
    map("n", "<leader>mt", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("- %[ %]") then
        vim.api.nvim_set_current_line(line:gsub("- %[ %]", "- [x]", 1))
      elseif line:match("- %[x%]") then
        vim.api.nvim_set_current_line(line:gsub("- %[x%]", "- [ ]", 1))
      end
    end, "Toggle checkbox")

    -- Plugin toggles
    map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", "Toggle markdown preview")
    map("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", "Toggle markdown rendering")
    map("n", "<leader>ms", function()
      vim.opt_local.spell = not vim.opt_local.spell:get()
    end, "Toggle spell check")
  end,
})
