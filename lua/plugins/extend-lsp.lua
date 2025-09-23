return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                -- чтобы не использовался stylua, а форматтер от lua_ls
                lua = {},
                -- html файлы с шаблонами внутри воспринимаются как htmldjango
                htmldjango = {"prettier"},
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
                enabled = false,
            },
            servers = {
                -- Ensure mason installs the server
                clangd = {
                    root_markers = {
                        ".root",
                        "compile_commands.json",
                        "compile_flags.txt",
                        "configure.ac", -- AutoTools
                        "Makefile",
                        "configure.ac",
                        "configure.in",
                        "config.h.in",
                        "meson.build",
                        "meson_options.txt",
                        "build.ninja",
                        ".git",
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                        -- с этим ключом стало падать
                        -- "--query-driver=/**/*", -- нужно для кросс компилятора, чтобы сам искал инклуды
                    },
                },
                neocmake = {
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(".root")(fname)
                    end,
                    init_options = {
                        lint = {
                            enable = false,
                        },
                    },
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function()
            if vim.g.lazyvim_picker ~= "telescope" then
                return
            end
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            vim.list_extend(keys, {
                {
                    "gd",
                    function() require("telescope.builtin").lsp_definitions({reuse_win = false}) end,
                    desc = "Goto Definition",
                    has = "definition",
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        opts = function()
            -- Настройка docker
            local hadolint = require("lint").linters.hadolint
            if type(hadolint) == "table" then
                -- DL3008 - исключаем "pin versions..."
                -- DL3015 - исключаем "Avoid additional packages by specifying `--no-install-recommends`"
                -- DL3059 - исключаем "Multiple consecutive `RUN` instructions. Consider consolidation"
                vim.list_extend(hadolint.args, {"--ignore", "DL3008", "--ignore", "DL3015", "--ignore", "DL3059"})
            end
        end,
    },
}
