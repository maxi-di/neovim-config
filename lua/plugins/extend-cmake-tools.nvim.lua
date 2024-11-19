return {
    {
        'Civitasv/cmake-tools.nvim',
        dependencies = {
            "folke/which-key.nvim",
            opts = {
                defaults = {},
                spec = {
                    {
                        {"<leader>z",  group = "Cmake"},
                        {"<leader>zo", group = "Cmake open some views"},
                        {"<leader>zs", group = "Cmake select..."},
                    }
                }
            }
        },

        opts = function(_, opts)
            vim.keymap.set("n", "<leader>zsb", '<cmd>CMakeSelectBuildType<cr>', {desc = "Cmake select build type"})
            vim.keymap.set("n", "<leader>zb", '<cmd>CMakeBuild<cr>', {desc = "Cmake build"})
            vim.keymap.set("n", "<leader>zg", '<cmd>CMakeGenerate<cr>', {desc = "Cmake generate"})
            vim.keymap.set("n", "<leader>zoe", '<cmd>CMakeOpenExecutor<cr>', {desc = "Cmake open executor"})
            vim.keymap.set("n", "<leader>zor", '<cmd>CMakeOpenRunner<cr>', {desc = "Cmake open runner"})

            -- local function augroup(name)
            --     return vim.api.nvim_create_augroup("max_" .. name, {clear = true})
            -- end
            -- vim.api.nvim_create_autocmd({"BufWritePost"}, {
            --     group    = augroup("cmake_auto_reconfigure"),
            --     pattern  = "CMakeLists.txt",
            --     callback = function()
            --         vim.cmd("CMakeGenerate")
            --     end,
            -- })

            opts = {
                cmake_command = "cmake",                                        -- this is used to specify cmake command path
                cmake_regenerate_on_save = true,                                -- auto generate when save CMakeLists.txt
                -- cmake_use_preset = false,                                       -- when `false`, this is used to define if the `--preset` option should be use on cmake commands
                cmake_generate_options = {"-DCMAKE_EXPORT_COMPILE_COMMANDS=1"}, -- this will be passed when invoke `CMakeGenerate`
                cmake_executor = {
                    opts = {},
                    default_opts = {
                        quickfix = {
                            auto_close_when_success = true,
                        }
                    }
                },
            }
            return opts
        end
    }
}
