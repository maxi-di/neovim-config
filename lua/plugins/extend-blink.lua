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
            sources = {
                providers = {
                    lsp = {
                        name = "LSP",
                        module = 'blink.cmp.sources.lsp',

                        -- Фильтрация и сортировка по LSP серверам
                        transform_items = function(ctx, items)
                            -- Задайте приоритет разным серверам
                            local priority = {
                                ['cssmodules_ls'] = 100,
                            }

                            for _, item in ipairs(items) do
                                local client_name = item.client_name or ''
                                item.score_offset = (item.score_offset or 0) + (priority[client_name] or 0)
                            end

                            return items
                        end,
                    },
                },
            },
            completion = {
                trigger = {
                    -- нужно, когда в cpp коде печатаешь начало шаблона '<', без этого не предлагает lsp подсказки
                    show_on_blocked_trigger_characters = {' ', '\n', '\t', '<'},
                },
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
