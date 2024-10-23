return {
    {
        "Shatur/neovim-session-manager",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
        },
        cmd = "SessionManager",
        opts = {
            sessions_dir = require('plenary.path'):new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
        },
        keys = {
            {"<leader>P", "<cmd>SessionManager load_session<cr>", desc = "Open session"},
            {"<A-l>",     "<cmd>SessionManager load_session<cr>", desc = "Open session"},
        },
    }
}
