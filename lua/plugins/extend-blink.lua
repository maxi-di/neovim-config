return {
    {
        "saghen/blink.cmp",
        tag = "v0.9.3",
        opts = {
            keymap = {
                preset = "super-tab",
                ["<C-g>"] = {'show', 'show_documentation', 'hide_documentation'},
            },
            completion = {
                list = {
                    -- for version v0.9.3
                    selection = "auto_insert",
                }
            }
            -- for newest versions
            -- completion = {
            --     list = {
            --         selection = {
            --             preselect = true,
            --             auto_insert = true,
            --         }
            --     },
            -- },
        },
    },
}
