-- better yank/paste
return {
    "gbprod/yanky.nvim",
    enabled = true,
    keys = {
        {
            "<leader>p",
            false,
        },
        {
            "<leader>y",
            function()
                if LazyVim.pick.picker.name == "telescope" then
                    require("telescope").extensions.yank_history.yank_history({})
                else
                    vim.cmd([[YankyRingHistory]])
                end
            end,
            mode = {"n", "x"},
            desc = "Open Yank History",
        },
    },
    opts = {
        system_clipboard = {
            -- из-за этого консоль бликала, когда я переключался на другое окно tmux
            sync_with_ring = false,
        },
        -- highlight = {
        --     on_put = false,
        --     on_yank = false,
        --     timer = 0,
        -- }
    }
}
