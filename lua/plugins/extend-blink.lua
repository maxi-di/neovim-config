return {
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                preset = "super-tab",
                ["<C-g>"] = {'show', 'show_documentation', 'hide_documentation'},
            },
            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    }
                },
            },
            enabled = function()
                -- Отключаем автодополнение для определенного типа файлов
                return not vim.tbl_contains({
                    "typr",
                    "TelescopePrompt",
                }, vim.bo.filetype)
            end,
        },
    },
}
