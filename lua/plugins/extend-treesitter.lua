return {
    "nvim-treesitter/nvim-treesitter",
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
            "qmljs",
            "html",
            "css",
            "bash",
            "javascript",
            "latex",
            "norg",
            "scss",
            "svelte",
            "typst",
            "vue"
        })
    end,
}
