return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,
                    side = "left",
                    preserve_window_proportions = true,
                },
                renderer = {
                    icons = {
                        show = {
                            git = true,
                            folder = true,
                            file = true,
                            modified = true,
                        },
                    },
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                diagnostics = {
                    enable = true,
                },
                filters = {
                    dotfiles = false,
                },
            })
            -- Keybinding to toggle
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        end
    }
}
