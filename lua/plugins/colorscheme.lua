return {
  {
    'morhetz/gruvbox',
    enabled = true,
    config = function()
      -- vim.g.gruvbox_bold = 0
      -- vim.g.gruvbox_contrast_dark = 'soft'
      -- vim.cmd.colorscheme 'gruvbox'
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
    'rebelot/kanagawa.nvim',
    enabled = true,
  },

  -- Configure LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "melange",
    },
  },
}
