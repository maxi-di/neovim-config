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
    {import = "lazyvim.plugins.extras.lang.python"},
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                -- чтобы не использовался stylua, а форматтер от lua_ls
                lua = {},
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                markdown = {},
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = {
                enabled = false
            },
            servers = {
                -- Ensure mason installs the server
                clangd = {
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            ".root",
                            "Makefile",
                            "configure.ac",
                            "configure.in",
                            "config.h.in",
                            "meson.build",
                            "meson_options.txt",
                            "build.ninja"
                        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                            fname
                        ) or require("lspconfig.util").find_git_ancestor(fname)
                    end,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                        "--query-driver=/**/*", -- нужно для кросс компилятора, чтобы сам искал инклуды
                    }
                },
                neocmake = {
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            ".root"
                        )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                    end,
                    init_options = {
                        lint = {
                            enable = false,
                        }
                    },
                },
            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        opts = function()
            if vim.g.lazyvim_picker ~= "telescope" then
                return
            end
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            vim.list_extend(keys, {
                {"gd", function() require("telescope.builtin").lsp_definitions({reuse_win = false}) end, desc = "Goto Definition", has = "definition"},
            })
        end,
    },
}
