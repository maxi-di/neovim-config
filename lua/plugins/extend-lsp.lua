return {
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
                -- чтобы не использовался stylua, а форматтер от lua_ls
                lua = {},
            },
        },
    },
}
