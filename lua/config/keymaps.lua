-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ct", "<cmd>Trouble telescope<cr>", {desc = "Trouble from telescope"})
vim.keymap.set("n", "<leader>x,", "<cmd>Trouble telescope<cr>", {desc = "Trouble from telescope"})
