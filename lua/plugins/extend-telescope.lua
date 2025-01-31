if vim.g.lazyvim_picker ~= "telescope" then
    return {}
end

return {
    "nvim-telescope/telescope.nvim",
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
