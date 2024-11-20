local first = true

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

                    -- you can find the icons from https://github.com/Civitasv/runvim/blob/master/lua/config/icons.lua
                    local icons = require("config.icons")

                    -- Inserts a component in lualine_c at left section
                    local function ins_left(component)
                        table.insert(opts.sections.lualine_c, component)
                    end

                    ins_left {
                        function()
                            local c_preset = require("cmake-tools").get_configure_preset()
                            return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
                        end,
                        icon = icons.ui.Search,
                        cond = function()
                            return require("cmake-tools").is_cmake_project() and
                                require("cmake-tools").has_cmake_preset()
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
                            -- здесь обязательно нужно `require`, т.к. после смены директории я перезапускаю плагин,
                            -- чтобы он обновил свои пути и состояния
                            -- и если `require` сделать только вначале ф-ии, то значение всех ф-ий замкнется на первое
                            -- включение
                            local type = require("cmake-tools").get_build_type()
                            return "CMake: [" .. (type and type or "") .. "]"
                        end,
                        icon = icons.ui.Search,
                        cond = function()
                            return require("cmake-tools").is_cmake_project() and
                                not require("cmake-tools").has_cmake_preset()
                        end,
                        on_click = function(n, mouse)
                            if (n == 1) then
                                if (mouse == "l") then
                                    vim.cmd("CMakeSelectBuildType")
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
            vim.keymap.set("n", "<leader>zr", function() require("lazy").reload({plugins = {"cmake-tools.nvim"}}) end,
                {desc = "Cmake reload plugin"})

            local function augroup(name)
                return vim.api.nvim_create_augroup("max_" .. name, {clear = true})
            end

            -- событие от плагина `neovim-session-manager.nvim`
            vim.api.nvim_create_autocmd({"User"}, {
                pattern  = "SessionLoadPost",
                group    = augroup("cmake_reload"),
                callback = function()
                    local cwd = vim.uv.cwd()
                    if vim.fn.filereadable(cwd .. "/CMakeLists.txt") ~= 1 then return end

                    if first then
                        first = false
                        return
                    end

                    vim.loop.new_timer():start(1000, 0, vim.schedule_wrap(function()
                        require("lazy").reload({plugins = {"cmake-tools.nvim"}})
                    end))
                end,
            })

            opts = {
                cmake_command = "cmake",                                        -- this is used to specify cmake command path
                cmake_regenerate_on_save = true,                                -- auto generate when save CMakeLists.txt
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
