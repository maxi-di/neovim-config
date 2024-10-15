-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
    return vim.api.nvim_create_augroup("max_" .. name, {clear = true})
end

vim.api.nvim_create_autocmd({"BufReadPost"}, {
    group    = augroup("koi8r"),
    pattern  = {"*.lua", "*.c"},
    callback = function(event)
        local s = vim.api.nvim_buf_get_lines(event.buf, 0, 1, true)[1]
        if s == nil then return end
        local encoding = s:match("encoding +(%w+)")
        if encoding then
            vim.cmd(string.format(":e ++enc=%s", encoding))
        end
        -- vim.notify(vim.inspect(result))
    end,
})
