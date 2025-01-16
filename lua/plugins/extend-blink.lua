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
        },
    },
}
