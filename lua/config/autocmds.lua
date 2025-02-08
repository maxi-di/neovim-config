-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

---@param name string
---@return integer
local function augroup(name)
    return vim.api.nvim_create_augroup("max_" .. name, {clear = true})
end

vim.api.nvim_create_autocmd({"BufReadPost"}, {
    group    = augroup("koi8r"),
    pattern  = {"*"},
    callback = function(event)
        local s = vim.api.nvim_buf_get_lines(event.buf, 0, 1, true)[1]
        if s == nil then return end
        local encoding = s:match("encoding +(%w+)")
        if encoding then
            vim.cmd(string.format(":e ++enc=%s", encoding))
        end
        -- vim.notify(s)
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
        pattern  = '*',
        ---@diagnostic disable-next-line: unused-local
        callback = function(event)
            if not package.loaded["neo-tree"] then
                return
            end
            local manager = require("neo-tree.sources.manager")
            if manager then
                manager.refresh('filesystem')
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
    end,
})

vim.api.nvim_create_autocmd({"FileType"}, {
    group    = augroup("disable_spell"),
    pattern  = {"markdown"},
    callback = function()
        vim.opt_local.spell = false
    end,
})
