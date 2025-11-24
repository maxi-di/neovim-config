-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here


-- Загрузить все буферы из сессии
-- Эта функция нужна, чтобы работали автодополнения Buffer из других буферов,
-- которые мы не открывали при старте, по в сессии они открыты (если вручную в них не зашли)
local function load_all_unloaded_buffers()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and not vim.api.nvim_buf_is_loaded(buf) then
            vim.fn.bufload(buf)
        end
    end
end

--- Возвращает список дочерних процессов с аргументами для данного PID
---@param parent_pid number
---@return table
local function get_child_processes(parent_pid)
    local result = {}
    if not parent_pid then
        return result
    end

    -- ps: выводим PID, команду и аргументы всех дочерних процессов
    local cmd = string.format("ps --no-headers -o pid=,args= --ppid %d", parent_pid)
    local handle = io.popen(cmd)
    if not handle then
        return result
    end

    for line in handle:lines() do
        -- пример строки: "12345 top -b"
        local pid, args = line:match("%s?(%d+)%s+(.*)$")
        if pid and args then
            table.insert(result, {pid = tonumber(pid), args = args})
        end
    end
    handle:close()

    return result
end


---@param name string
---@return integer
local function augroup(name)
    return vim.api.nvim_create_augroup("max_" .. name, {clear = true})
end

vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern  = {"*"},
    group    = augroup("koi8r"),
    callback = function(event)
        local s = vim.api.nvim_buf_get_lines(event.buf, 0, 1, true)[1]
        if s == nil then return end
        local encoding = s:match("encoding +(%w+)")
        if encoding then
            vim.cmd(string.format(":e ++enc=%s", encoding))
        end
    end,
})

vim.api.nvim_create_autocmd({"BufRead"}, {
    group    = augroup("json_to_jsonc"),
    pattern  = {"launch.json", "tasks.json", "devcontainer.json"},
    ---@diagnostic disable-next-line: unused-local
    callback = function(event)
        vim.cmd(string.format(":set filetype=jsonc"))
    end,
})

vim.api.nvim_create_autocmd({"BufReadPost"}, {
    group    = augroup("detect_dockerfile"),
    pattern  = {"Dockerfile*"},
    ---@diagnostic disable-next-line: unused-local
    callback = function(event)
        vim.cmd(string.format(":set filetype=dockerfile"))
    end,
})

if LazyVim.has("neo-tree.nvim") then
    vim.api.nvim_create_autocmd({"TabEnter"}, {
        pattern  = "*",
        ---@diagnostic disable-next-line: unused-local
        callback = function(event)
            if not package.loaded["neo-tree"] then
                return
            end
            local manager = require("neo-tree.sources.manager")
            if manager then
                manager.refresh("filesystem")
            end
        end,
    })
end

-- событие от плагина `neovim-session-manager.nvim`
vim.api.nvim_create_autocmd({"User"}, {
    pattern  = "SessionLoadPost",
    group    = augroup("lsp_restart"),
    callback = function()
        vim.cmd(":LspRestart")
        vim.notify("Lsp restarting (on cwd changed)")
        load_all_unloaded_buffers()
    end,
})

vim.defer_fn(load_all_unloaded_buffers, 100)

vim.api.nvim_create_autocmd({"FileType"}, {
    group    = augroup("disable_spell"),
    pattern  = {"markdown"},
    callback = function()
        vim.opt_local.spell = false
    end,
})

-- если в *.html файле вписаны шаблоны, то он воспринимается как htmldjango
-- из-за этого плохо работает автозакрытие тегов
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    group    = augroup("detect_html"),
    pattern  = {"*.html"},
    ---@diagnostic disable-next-line: unused-local
    callback = function(event)
        vim.cmd(string.format(":set filetype=html"))
    end,
})

-- Перерисовать lf file manager (если он был открыт, то ломается интерфейс)
vim.api.nvim_create_autocmd({"BufEnter"}, {
    callback = function(event)
        local bufnr = event.buf

        local bt = vim.bo[bufnr].buftype
        if bt ~= "terminal" then return end

        local pid = vim.b[bufnr].terminal_job_pid
        if not pid then return end

        local children = get_child_processes(pid)

        for _, value in ipairs(children) do
            if value.args:match("lf %-last%-dir%-path") then
                io.popen(string.format('lf -remote "send %d redraw"', value.pid))
            end
        end

    end,
})

vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern  = {"*.html", "*.css"},
    callback = function(_)
        vim.defer_fn(function()
            if package.loaded["ccc"] then
                vim.cmd("CccHighlighterDisable")
                vim.cmd("CccHighlighterEnable")
            end
        end, 10)
    end,
})


-- transparent background
if true then
    vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})

    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
            vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
            vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
        end,
    })
end
