return {
    {
        "sindrets/diffview.nvim",
        dependencies = {'nvim-tree/nvim-web-devicons'},
        opts = function(_, opts)
            opts.view = {
                merge_tool = {
                    layout = "diff3_mixed",
                }
            }

            local function augroup(name)
                return vim.api.nvim_create_augroup("max_" .. name, {clear = true})
            end

            vim.api.nvim_create_autocmd('FileType', {
                group = augroup("custom_diffview_keymaps"),
                pattern = "DiffviewFiles",
                callback = function(args)
                    vim.keymap.set('n', 'q', '<cmd>DiffviewClose<cr>',
                        {buffer = args.buf, desc = 'Close diffview'})
                end
            })
        end,
        keys = {
            {"<leader>go", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview"},
        }
    }
}
