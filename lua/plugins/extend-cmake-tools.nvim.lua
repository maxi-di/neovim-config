return {
    {
        'Civitasv/cmake-tools.nvim',
        dependencies = {
            {
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
            {
                "nvim-lualine/lualine.nvim",
                opts = function(_, opts)

                    local cmake = require("cmake-tools")

                    -- you can find the icons from https://github.com/Civitasv/runvim/blob/master/lua/config/icons.lua
                    local icons = require("config.icons")

                    -- Inserts a component in lualine_c at left section
                    local function ins_left(component)
                        table.insert(opts.sections.lualine_c, component)
                    end

                    -- Inserts a component in lualine_x ot right section
                    local function ins_right(component)
                        table.insert(opts.sections.lualine_x, component)
                    end

                    ins_left {
                        function()
                            local c_preset = cmake.get_configure_preset()
                            return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
                        end,
                        icon = icons.ui.Search,
                        cond = function()
                            return cmake.is_cmake_project() and cmake.has_cmake_preset()
                        end,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeSelectConfigurePreset")
                                end
                            end
                        end
                    }

                    ins_left {
                        function()
                            local type = cmake.get_build_type()
                            return "CMake: [" .. (type and type or "") .. "]"
                        end,
                        icon = icons.ui.Search,
                        cond = function()
                            return cmake.is_cmake_project() and not cmake.has_cmake_preset()
                        end,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeSelectBuildType")
                                end
                            end
                        end
                    }

                    ins_left {
                        function()
                            local kit = cmake.get_kit()
                            return "[" .. (kit and kit or "X") .. "]"
                        end,
                        icon = icons.ui.Pencil,
                        cond = function()
                            return cmake.is_cmake_project() and not cmake.has_cmake_preset()
                        end,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeSelectKit")
                                end
                            end
                        end
                    }

                    ins_left {
                        function()
                            return "Build"
                        end,
                        icon = icons.ui.Gear,
                        cond = cmake.is_cmake_project,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeBuild")
                                end
                            end
                        end
                    }

                    ins_left {
                        function()
                            local b_preset = cmake.get_build_preset()
                            return "[" .. (b_preset and b_preset or "X") .. "]"
                        end,
                        icon = icons.ui.Search,
                        cond = function()
                            return cmake.is_cmake_project() and cmake.has_cmake_preset()
                        end,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeSelectBuildPreset")
                                end
                            end
                        end
                    }

                    ins_left {
                        function()
                            local b_target = cmake.get_build_target()
                            return "[" .. (b_target and b_target or "X") .. "]"
                        end,
                        cond = cmake.is_cmake_project,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeSelectBuildTarget")
                                end
                            end
                        end
                    }

                    ins_left {
                        function()
                            return icons.ui.Debug
                        end,
                        cond = cmake.is_cmake_project,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeDebug")
                                end
                            end
                        end
                    }

                    ins_left {
                        function()
                            return icons.ui.Run
                        end,
                        cond = cmake.is_cmake_project,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeRun")
                                end
                            end
                        end
                    }

                    ins_left {
                        function()
                            local l_target = cmake.get_launch_target()
                            return "[" .. (l_target and l_target or "X") .. "]"
                        end,
                        cond = cmake.is_cmake_project,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeSelectLaunchTarget")
                                end
                            end
                        end
                    }

                end,

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
