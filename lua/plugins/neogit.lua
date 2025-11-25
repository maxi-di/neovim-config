local function neogit_in_current_cwd()
    local neogit = require("neogit")
    local file_dir = vim.fn.expand("%:h")
    local exec_result = vim.system({"git", "rev-parse", "--show-toplevel"}, {text = true, cwd = file_dir})
        :wait()
    local root = vim.fn.trim(exec_result.stdout)
    neogit.open({kind = "tab", cwd = root})
end

return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua",              -- optional
        "nvim-mini/mini.pick",           -- optional
    },
    opts = {
        integrations = {
            diffview = true,
        },
        graph_style = "unicode",
        mappings = {
            commit_editor = {
                ["<m-b>"] = "PrevMessage",
                ["<m-f>"] = "NextMessage",
            },
        }
    },
    keys = {
        {"<A-g>",     neogit_in_current_cwd, desc = "Open neo-git"},
        {"<leader>G", neogit_in_current_cwd, desc = "Open neo-git"},
    },
    config = true
}
