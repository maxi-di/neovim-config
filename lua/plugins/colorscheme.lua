return {
    {
        'morhetz/gruvbox',
        enabled = false,
        config = function()
            vim.g.gruvbox_contrast_dark = "soft"
        end,
    },
    {
        'ellisonleao/gruvbox.nvim',
        enabled = true,
        opts = function(_, opts)
            ---@type GruvboxPalette
            local p               = require("gruvbox").palette
            local config          = require("gruvbox").config
            opts.contrast         = "soft"
            opts.inverse          = true
            opts.transparent_mode = false
            opts.invert_signs     = false
            opts.overrides        = {
                Search            = {fg = p.faded_yellow},
                LspReferenceRead  = {fg = p.light1, bg = p.dark_green_soft, reverse = config.invert_signs},
                LspReferenceWrite = {fg = p.light0, bg = p.faded_green, reverse = config.invert_signs},
                DiffText          = {bg = p.faded_yellow, fg = p.dark0},
            }
            vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', {link = "GruvboxGreenBold"})
            vim.api.nvim_set_hl(0, 'SnippetTabstop', {link = "GruvboxGreenBold"})
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

    -- Configure LazyVim to load colorscheme
    {
        "LazyVim/LazyVim",
    },
}
