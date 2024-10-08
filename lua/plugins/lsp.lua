return {
    "neovim/nvim-lspconfig",
    opts = {
        ---@type lspconfig.options
        servers = {
            -- pyright will be automatically installed with mason and loaded with lspconfig
            lua_ls = {
                root_dir = require 'lspconfig'.util.root_pattern(".lua_root", ".git", ".vscode"),
            },
        },
    },
}
