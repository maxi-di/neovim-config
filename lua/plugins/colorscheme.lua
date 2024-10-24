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
        opts = {
            contrast = "soft",
        }
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
        opts = {
            colorscheme = "gruvbox",
        },
    },
}
