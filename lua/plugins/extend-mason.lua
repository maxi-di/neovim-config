return {
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)
            opts.ensure_installed = vim.tbl_filter(function(pkg)
                return pkg ~= "stylua"
            end, opts.ensure_installed or {})

            -- Или добавляем другие пакеты без stylua
            vim.list_extend(opts.ensure_installed, {
                "htmx-lsp",
                -- другие пакеты
            })
        end,
    },
}
