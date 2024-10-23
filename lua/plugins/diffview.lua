return {
    {
        "sindrets/diffview.nvim",
        dependencies = {'nvim-tree/nvim-web-devicons'},
        opts = {
            view = {
                merge_tool = {
                    layout = "diff3_mixed",
                }
            }
        },
        keys = {
            {"<leader>go", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen"},
            --     {"<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose"},
            --     {"<A-g>",      "<cmd>DiffviewOpen<cr>",  desc = "DiffviewOpen"},
        }
    }
}
