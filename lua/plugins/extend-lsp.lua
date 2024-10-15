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
    {import = "lazyvim.plugins.extras.lang.json"},
    {import = "lazyvim.plugins.extras.lang.clangd"},
    {import = "lazyvim.plugins.extras.lang.cmake"},
    {import = "lazyvim.plugins.extras.lang.docker"},
    {import = "lazyvim.plugins.extras.lang.git"},
    {import = "lazyvim.plugins.extras.lang.go"},
    {import = "lazyvim.plugins.extras.lang.markdown"},
    {import = "lazyvim.plugins.extras.lang.toml"},
    {import = "lazyvim.plugins.extras.lang.yaml"},
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
