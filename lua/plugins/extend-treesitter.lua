return {
    "nvim-treesitter/nvim-treesitter",
    -- opts = {
    --     indent = {
    --         disable = {
    --             "yaml",
    --         },
    --     },
    -- },
    opts = function(_, opts)
        opts.indent = {
            disable = {
                "yaml"
            }
        }
        -- add tsx and treesitter
        vim.list_extend(opts.ensure_installed, {
            "tsx",
            "typescript",
            "qmljs"
        })
    end,
}
