return {
    {
        "xzbdmw/colorful-menu.nvim",
        config = true,
    },
    {
        "saghen/blink.cmp",
        tag = "v1.3.1", -- remove later after LazyVim updates
        opts = {
            keymap = {
                preset = "super-tab",
                ["<C-g>"] = {'show', 'show_documentation', 'hide_documentation'},
            },
            completion = {
                menu = {
                    border = 'rounded',
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = {{"kind_icon"}, {"label", gap = 1}},
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
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
                    "snacks_picker_input",
                }, vim.bo.filetype)
            end,
        },
    },
}
