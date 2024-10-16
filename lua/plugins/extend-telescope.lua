return {
    "nvim-telescope/telescope.nvim",
    keys = {
        {"<C-p>", LazyVim.pick("files", {root = false}), desc = "Find Files (cwd)"},
    }
}
