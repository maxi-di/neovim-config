local function ts_disable(_, bufnr)
    return vim.api.nvim_buf_line_count(bufnr) > 200
end

return {
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    opts = {
        highlight = {
            enable = false,
            disable = ts_disable,
            -- additional_vim_regex_highlighting = {"latex"},
        },
    }
}
