return {
    {
        "folke/which-key.nvim",
        opts = {
            defaults = {},
            spec = {
                {
                    mode = {"n", "v"},
                    {"<leader>h", group = "git hunk actions"},
                },
                {
                    mode = {"n", "v"},
                    {"<leader>C", group = "Color picker, sync-conflicts"}
                },
            },
        },
    },
}
