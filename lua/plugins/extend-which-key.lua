return {
    {
        "folke/which-key.nvim",
        opts = {
            defaults = {},
            spec = {
                {
                    mode = {"n", "v"},
                    {"<leader>h", group = "git hunk actions"},
                }
            }
        }
    }
}
