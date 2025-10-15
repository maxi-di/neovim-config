return {
    {
        "xzbdmw/colorful-menu.nvim",
        config = true,
    },
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                preset = "super-tab",
                ["<C-g>"] = {"show", "show_documentation", "hide_documentation"},
            },
            completion = {
                menu = {
                    border = "rounded",
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = {{"kind_icon"}, {"label"}, {"source_name"}, {"lsp_name"}},
                        components = {
                            lsp_name = {
                                text = function(ctx)
                                    -- Получаем информацию о LSP-клиенте
                                    if ctx.source_name == 'LSP' and ctx.item.client_id then
                                        local client = vim.lsp.get_client_by_id(ctx.item.client_id)
                                        if client then
                                            return "[" .. client.name .. "]"
                                        end
                                    end
                                    return ""
                                end,
                                highlight = "Comment", -- цвет текста
                            },
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
                    },
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
