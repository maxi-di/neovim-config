return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            ---@type lspconfig.options
            servers = {
                lua_ls = {
                    root_dir = require 'lspconfig'.util.root_pattern(".luarc.json", ".git", ".vscode"),
                },
            },
        },
    },
    {
        import = "lazyvim.plugins.extras.lang.json",
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                -- чтобы не использовалься stylua, а форматтер от lua_ls
                lua = {},
            },
        },
    }
}
