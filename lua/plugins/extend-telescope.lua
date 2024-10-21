return {
    "nvim-telescope/telescope.nvim",
    keys = {
        {"<C-p>", LazyVim.pick("files", {root = false}), desc = "Find Files (cwd)"},
    },
    opts = {
        pickers = {
            find_files = {
                theme = 'dropdown',
            },
            git_files = {
                theme = 'dropdown',
            },
            grep_string = {
                theme = 'dropdown',
            },
            live_grep = {
                theme = 'dropdown',
            },
        },
    }
}
