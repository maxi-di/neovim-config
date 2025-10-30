return {
    -- Работа с файловой системой как с простым буфером
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    cmd = {"Oil"},
    keys = {
        {
            "<leader>O",
            string.format("<cmd>Oil %s<cr>", vim.uv.cwd()),
            desc = "Oil - interactive file manager"
        },
    },
    -- Optional dependencies
    dependencies = {"nvim-mini/mini.icons", opts = {}},
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = true,
    default_file_explorer = false,
}
