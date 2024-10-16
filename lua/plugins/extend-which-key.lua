return {
    {
        "folke/which-key.nvim",
        opts = {
            defaults = {},
            spec = {
                {
                    mode = {"n", "v"},
                    {"<leader>d", group = "git diffview"},
                    {"<leader>h", group = "git hunk actions"},
                }
            }
        }
    }
}
