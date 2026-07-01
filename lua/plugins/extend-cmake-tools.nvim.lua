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
                local current_path = vim.uv.cwd() or ""
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

            local function qt_generage_compile_commands()
                local pro_file = vim.fn.expand("%:p")
                if vim.fn.fnamemodify(pro_file, ":e") ~= "pro" then
                    vim.notify("Текущий файл не .pro", vim.log.levels.ERROR)
                    return
                end

                if vim.fn.executable("compiledb") == 0 then
                    vim.notify(
                        "compiledb не найден. Установка:\n"
                        .. "  pip install compiledb --break-system-packages\n"
                        .. "(нужен python3-pip: sudo apt install python3-pip)",
                        vim.log.levels.ERROR
                    )
                    return
                end

                local pro_dir = vim.fn.fnamemodify(pro_file, ":h")
                local build_dir = pro_dir .. "/build_qt"

                vim.fn.mkdir(build_dir, "p")
                vim.notify("Генерация compile_commands.json...", vim.log.levels.INFO)

                local qmake_cmd = string.format(
                    "cd %s && qmake %s",
                    vim.fn.shellescape(build_dir),
                    vim.fn.shellescape(pro_file)
                )

                vim.fn.jobstart(qmake_cmd, {
                    on_exit = function(_, code)
                        if code ~= 0 then
                            vim.notify("Ошибка qmake (код " .. code .. ")", vim.log.levels.ERROR)
                            return
                        end

                        -- ищем все Makefile* в build_dir, включая поддиректории (subdirs-проект)
                        local makefiles = vim.fn.systemlist(
                            string.format(
                                "find %s -maxdepth 3 -type f \\( -name 'Makefile' -o -name 'Makefile*' \\)",
                                vim.fn.shellescape(build_dir)
                            )
                        )

                        if #makefiles == 0 then
                            vim.notify("Makefile не найден после qmake в " .. build_dir, vim.log.levels.ERROR)
                            return
                        end

                        -- приоритет: обычный Makefile, иначе Makefile.Debug, иначе первый попавшийся
                        local makefile
                        for _, f in ipairs(makefiles) do
                            if vim.fn.fnamemodify(f, ":t") == "Makefile" then
                                makefile = f
                                break
                            end
                        end
                        if not makefile then
                            for _, f in ipairs(makefiles) do
                                if f:match("Makefile%.Debug$") then
                                    makefile = f
                                    break
                                end
                            end
                        end
                        makefile = makefile or makefiles[1]

                        local mk_dir = vim.fn.fnamemodify(makefile, ":h")
                        local mk_name = vim.fn.fnamemodify(makefile, ":t")

                        vim.notify("Используется " .. makefile, vim.log.levels.INFO)

                        local compiledb_cmd = string.format(
                            "cd %s && compiledb -n make -f %s -B",
                            vim.fn.shellescape(mk_dir),
                            vim.fn.shellescape(mk_name)
                        )

                        vim.fn.jobstart(compiledb_cmd, {
                            stderr_buffered = true,
                            on_exit = function(_, ccode)
                                if ccode ~= 0 then
                                    vim.notify("Ошибка compiledb (код " .. ccode .. ")", vim.log.levels.ERROR)
                                    return
                                end

                                local src = mk_dir .. "/compile_commands.json"
                                local dst = pro_dir .. "/compile_commands.json"

                                if vim.fn.filereadable(src) == 0 then
                                    vim.notify("compile_commands.json не создан в " .. mk_dir, vim.log.levels.ERROR)
                                    return
                                end

                                if vim.fn.getftype(dst) == "link" or vim.fn.filereadable(dst) == 1 then
                                    vim.fn.delete(dst)
                                end

                                vim.loop.fs_symlink(src, dst, function(err)
                                    vim.schedule(function()
                                        if err then
                                            vim.notify("Не удалось создать симлинк: " .. err, vim.log.levels.ERROR)
                                        else
                                            vim.notify("compile_commands.json готов: " .. dst, vim.log.levels.INFO)
                                        end
                                    end)
                                end)
                            end,
                            on_stderr = function(_, data)
                                local msg = table.concat(data, "\n")
                                if msg:match("%S") then
                                    vim.notify(msg, vim.log.levels.WARN)
                                end
                            end,
                        })
                    end,
                })
            end

            vim.api.nvim_create_user_command("CMakeDeleteBuildDir", function() cmake_delete_build_dir(false) end, {
                nargs = 0,
                desc = "Delete Cmake Build Dir"
            })

            vim.api.nvim_create_user_command("CMakeDeleteCacheFile", function() cmake_delete_cache_file(false) end, {
                nargs = 0,
                desc = "Delete Cmake Cache File"
            })

            vim.api.nvim_create_user_command("QTGenerageCompileCommands", function() qt_generage_compile_commands() end,
                {
                    nargs = 0,
                    desc = "QT generate compile commands from *.pro file"
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
            vim.keymap.set("n", "<leader>zq", '<cmd>QTGenerageCompileCommands<cr>',
                {desc = "QT compile_commands.json from *.pro"})

            -- событие от плагина `neovim-session-manager.nvim`
            vim.api.nvim_create_autocmd({"User"}, {
                pattern  = "SessionLoadPost",
                group    = augroup("cmake_reload"),
                callback = function()
                    if first then
                        first = false
                        return
                    end
                    if cmake_get_cache_file() then
                        cmake_reload_plugin(10)
                    end
                end,
            })

            opts = {
                cmake_command = "cmake",                                        -- this is used to specify cmake command path
                cmake_build_options = {"-j4"},                                  -- this will be passed when invoke `CMakeBuild`
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
