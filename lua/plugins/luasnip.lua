return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local ls = require("luasnip")

    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = { virt_text = { { "●", "Comment" } } },
        },
      },
    })

    -- Load snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/luasnippets" })

    -- Snippet keybindings (don't conflict with nvim-cmp)
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.expand_or_jumpable() then ls.expand_or_jump() end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if ls.jumpable(-1) then ls.jump(-1) end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-n>", function()
      if ls.choice_active() then ls.change_choice(1) end
    end, { silent = true })
  end,
}
