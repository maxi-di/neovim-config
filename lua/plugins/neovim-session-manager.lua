return {
    {
        "Shatur/neovim-session-manager",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
        },
        cmd = "SessionManager",
        opts = function(_, opts)
            local config       = require('session_manager.config')
            opts.sessions_dir  = require('plenary.path'):new(vim.fn.stdpath('data'), 'sessions') -- The directory where the session files will be saved.
            opts.autoload_mode = {config.AutoloadMode.CurrentDir, config.AutoloadMode.LastSession}
        end,
        keys = {
            {"<leader>P", "<cmd>SessionManager load_session<cr>", desc = "Open session"},
            {"<A-l>",     "<cmd>SessionManager load_session<cr>", desc = "Open session"},
        },
    }
}
