return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua",              -- optional
        "echasnovski/mini.pick",         -- optional
    },
    opts = {
        integrations = {
            diffview = true,
        },
        graph_style = "unicode",
    },
    keys = {
        {"<A-g>",     "<cmd>Neogit<cr>", desc = "Open neo-git"},
        {"<leader>G", "<cmd>Neogit<cr>", desc = "Open neo-git"},
    },
    config = true
}
