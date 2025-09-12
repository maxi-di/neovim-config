-- Работа с hex цветом
return {
    {
        "uga-rosa/ccc.nvim",
        dependencies = {
            {
                "folke/which-key.nvim",
                opts = {
                    defaults = {},
                    spec = {{{"<leader>C", group = "Color picker"},}}
                }
            },
        },
        opts = function(_, opts)
            opts = {
                highlighter = {
                    auto_enable = true,
                }
            }
            vim.keymap.set("n", "<leader>Cc", '<cmd>CccPick<cr>', {desc = "Pick a color"})
            vim.keymap.set("n", "<leader>Cr", '<cmd>CccHighlighterDisable<cr><cmd>CccHighlighterEnable<cr>',
                {desc = "Reset highlighter"})
            return opts
        end,
    }
}
