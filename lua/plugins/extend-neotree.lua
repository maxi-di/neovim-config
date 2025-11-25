return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            filesystem = {
                follow_current_file = {
                    -- This will find and focus the file in the active buffer every time
                    -- the current file is changed while the tree is open.
                    enabled = false,
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
            }
        },
        keys = {
            {
                "<leader>fn",
                function()
                    vim.cmd("Neotree reveal_force_cwd")
                end,
                desc = "Reveal current file"
            },
        },
    },
}
