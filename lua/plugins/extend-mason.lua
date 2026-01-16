return {
    {
        "mason-org/mason.nvim",
        optional = true,
        opts = function(_, opts)

            -- lazyvim ставит какие-то lsp автоматически
            -- тут мы запрещаем ему это делать
            opts.ensure_installed = vim.tbl_filter(function(pkg)
                return pkg ~= "stylua"
            end, opts.ensure_installed or {})

            -- или добавляем другие пакеты без stylua
            vim.list_extend(opts.ensure_installed, {
                -- "htmx-lsp",
                "typescript-language-server",
                "vue-language-server",
                "mbake",
                "shfmt",
                "tinymist",
                "css-lsp",
                "stylelint", -- для css показывать ошибки
            })

        end,
    },
}
