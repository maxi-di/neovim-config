return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)

            -- Credited to [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua)
            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
                end,
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
                check_git_workspace = function()
                    local filepath = vim.fn.expand("%:p:h")
                    local gitdir = vim.fn.finddir(".git", filepath .. ";")
                    return gitdir and #gitdir > 0 and #gitdir < #filepath
                end,
            }

            -- Inserts a component in lualine_x ot right section
            local function ins_right(component)
                table.insert(opts.sections.lualine_x, component)
            end

            -- Add components to right sections
            ins_right {
                "o:encoding", -- option component same as &encoding in viml
                cond = conditions.hide_in_width,
            }

            ins_right {
                "filetype",
                icons_enabled = false,
            }

            ins_right {
                "shiftwidth",
                icons_enabled = false,
            }

        end,

    }
}
