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
                    -- с первого раза только разворачивает папку,
                    -- но не фокусируется на конеретном файле
                    local file_name = vim.fn.expand("%")
                    vim.cmd("Neotree reveal_file=" .. file_name)
                    vim.cmd("Neotree reveal_file=" .. file_name)
                end,
                desc = "Reveal current file"
            },
        },
    },
}
