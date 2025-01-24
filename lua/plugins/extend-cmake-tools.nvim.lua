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
                            {"<leader>zd", group = "Cmake delete..."},
                        }
                    }
                }
            },
            {
                "nvim-lualine/lualine.nvim",
                dependencies = {
                    "folke/snacks.nvim"
                },
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
            local osys = require("cmake-tools.osys")

            local function augroup(name)
                return vim.api.nvim_create_augroup("max_" .. name, {clear = true})
            end

            ---@param force boolean
            local function cmake_delete_build_dir(force)
                if not osys.islinux then
                    vim.notify("Delete cmake build dir not supported\non Not Linux")
                    return
                end

                local build_directory = (require("cmake-tools").get_build_directory() or {}).filename

                if build_directory and build_directory ~= "" then
                    if force then
                        os.execute("rm -rf " .. build_directory)
                    else
                        vim.ui.select({"yes", "no"}, {
                            prompt = "Delete cmake build dir:\n" .. build_directory,
                            prompt_item = function(item)
                                return "i'd like to select " .. item
                            end
                        }, function(choice)
                            if choice == "yes" then
                                vim.notify("Delete cmake build dir:\n" .. build_directory)
                                os.execute("rm -rf " .. build_directory)
                            end
                        end)
                    end
                end
            end

            ---@return string? 'cache file'
            ---@return string? 'clean path'
            local function cmake_get_cache_file()
                local cache_directory = vim.fn.expand("~") .. "/.cache/cmake_tools_nvim/"
                local current_path = vim.loop.cwd() or ""
                local clean_path = current_path:gsub("/", "")
                clean_path = clean_path:gsub("\\", "")
                clean_path = clean_path:gsub(":", "")

                cache_directory = cache_directory .. clean_path .. ".lua"

                if vim.fn.filereadable(cache_directory) == 0 then
                    return
                else
                    return cache_directory, clean_path
                end
            end

            ---@param force boolean
            local function cmake_delete_cache_file(force)
                if not osys.islinux then
                    vim.notify("Delete cmake cache file not supported\n on Not Linux")
                    return
                end
                local cache_directory, clean_path = cmake_get_cache_file()
                cache_directory = cache_directory or ""

                if cache_directory == "" then
                    return
                end

                if force then
                    os.execute("rm -rf " .. cache_directory)
                else
                    vim.ui.select({"yes", "no"}, {
                        prompt = "Delete cmake cache file:\n" .. clean_path,
                        prompt_item = function(item)
                            return "i'd like to select " .. item
                        end
                    }, function(choice)
                        if choice == "yes" then
                            vim.notify("Delete cmake cache file:\n" .. cache_directory)
                            os.execute("rm -rf " .. cache_directory)
                        end
                    end)
                end
            end

            ---@param after number? milliseconds
            local function cmake_reload_plugin(after)
                vim.loop.new_timer():start(after or 0, 0, vim.schedule_wrap(function()
                    require("lazy").reload({plugins = {"cmake-tools.nvim"}})
                end))
            end

            vim.api.nvim_create_user_command("CMakeDeleteBuildDir", function() cmake_delete_build_dir(false) end, {
                nargs = 0,
                desc = "Delete Cmake Build Dir"
            })

            vim.api.nvim_create_user_command("CMakeDeleteCacheFile", function() cmake_delete_cache_file(false) end, {
                nargs = 0,
                desc = "Delete Cmake Cache File"
            })


            vim.keymap.set("n", "<leader>zsb", '<cmd>CMakeSelectBuildType<cr>', {desc = "Cmake select build type"})
            vim.keymap.set("n", "<leader>zsc", '<cmd>CMakeSelectCwd<cr>', {desc = "Cmake select cwd"})
            vim.keymap.set("n", "<leader>zb", '<cmd>CMakeBuild<cr>', {desc = "Cmake build"})
            vim.keymap.set("n", "<leader>zg", '<cmd>CMakeGenerate<cr>', {desc = "Cmake generate"})
            vim.keymap.set("n", "<leader>zoe", '<cmd>CMakeOpenExecutor<cr>', {desc = "Cmake open executor"})
            vim.keymap.set("n", "<leader>zor", '<cmd>CMakeOpenRunner<cr>', {desc = "Cmake open runner"})
            vim.keymap.set("n", "<leader>zr", function() cmake_reload_plugin() end,
                {desc = "Cmake reload plugin"})
            vim.keymap.set("n", "<leader>zdb", function() cmake_delete_build_dir(false) end,
                {desc = "Cmake delete build dir"})
            vim.keymap.set("n", "<leader>zdc", function() cmake_delete_cache_file(false) end,
                {desc = "Cmake delete cache file"})
            vim.keymap.set("n", "<leader>zdr", function() cmake_reload_plugin() end,
                {desc = "Cmake reload plugin"})
            vim.keymap.set("n", "<leader>zdp", function()
                    cmake_delete_build_dir(true)
                    cmake_delete_cache_file(true)
                    cmake_reload_plugin()
                end,
                {desc = "Cmake prune plugin (delete cache's and reload)"})
            vim.keymap.set("n", "<F7>", '<cmd>CMakeBuild<cr>', {desc = "Cmake build"})


            -- событие от плагина `neovim-session-manager.nvim`
            vim.api.nvim_create_autocmd({"User"}, {
                pattern  = "SessionLoadPost",
                group    = augroup("cmake_reload"),
                callback = function()
                    if cmake_get_cache_file() then
                        cmake_reload_plugin(1000)
                    end
                end,
            })

            opts = {
                cmake_command = "cmake",                                        -- this is used to specify cmake command path
                cmake_regenerate_on_save = true,                                -- auto generate when save CMakeLists.txt
                cmake_generate_options = {"-DCMAKE_EXPORT_COMPILE_COMMANDS=1"}, -- this will be passed when invoke `CMakeGenerate`
                cmake_build_directory = function()
                    return "build"
                    -- if osys.iswin32 then
                    --     return "out\\${variant:buildType}"
                    -- end
                    -- return "out/${variant:buildType}"
                end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
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
