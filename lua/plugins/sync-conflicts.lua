return {
    "maxi-di/sync-conflicts.nvim",
    cmd = "SyncConflicts",
    config = {
        keymaps = {
            keep_conflict = "<leader>Ck",
            keep_original = "<leader>Co",
            quit          = "q"
        }
    },
    keys = {
        {"<leader>CC", "<cmd>SyncConflicts<cr>", desc = "SyncConflicts"},
    }
}
