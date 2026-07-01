return {
    {
        'ellisonleao/gruvbox.nvim',
        enabled = true,
        opts = function(_, opts)
            ---@type GruvboxPalette
            local p                = require("gruvbox").palette
            local config           = require("gruvbox").config
            opts.contrast          = "soft"
            opts.inverse           = true
            opts.transparent_mode  = false
            opts.invert_signs      = false
            opts.overrides         = {
                Search            = {fg = p.faded_yellow},
                LspReferenceRead  = {fg = p.light1, bg = p.dark_green_soft, reverse = config.invert_signs},
                LspReferenceWrite = {fg = p.light0, bg = p.faded_green, reverse = config.invert_signs},
                DiffText          = {bg = p.faded_yellow, fg = p.dark0},
            }

            local transparent_mode = true

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "gruvbox",
                callback = function()
                    vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', {link = "GruvboxGreenBold"})
                    vim.api.nvim_set_hl(0, 'SnippetTabstop', {link = "GruvboxGreenBold"})
                    vim.api.nvim_set_hl(0, 'BufferLineBufferSelected', {link = "GruvboxOrangeBold"})

                    vim.api.nvim_set_hl(0, "NeogitDiffAddInline", {fg = "#44cf26", bg = "#565756"})
                    vim.api.nvim_set_hl(0, "NeogitDiffDeleteInline", {fg = "#fb3118", bg = "#565756"})
                    vim.api.nvim_set_hl(0, "NeogitDiffDeleteCursor", {fg = "#fb4934", bg = "#83000f"})
                    vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", {fg = "#fb4934", bg = "#93000f"})

                    -- transparent background
                    if transparent_mode then
                        vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
                        vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
                        vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})

                    end
                end
            })
            if transparent_mode then
                vim.api.nvim_create_autocmd("ColorScheme", {
                    pattern = "*",
                    callback = function()
                        vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
                        vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
                    end,
                })
            end

        end
    },
    {
        'navarasu/onedark.nvim',
        enabled = true
    },
    {
        'catppuccin/nvim',
        enabled = true
    },
    {
        'savq/melange-nvim',
        enabled = true,
    },
    {
        'romainl/Apprentice',
        enabled = true,
    },
    {
        'projekt0n/github-nvim-theme',
        name   = 'github-theme',
        config = true,
    },

    -- Configure LazyVim to load colorscheme
    {
        "LazyVim/LazyVim",
    },
}
