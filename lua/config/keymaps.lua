-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ct", "<cmd>Trouble telescope<cr>", {desc = "Trouble from telescope"})
vim.keymap.set("n", "<leader>x,", "<cmd>Trouble telescope<cr>", {desc = "Trouble from telescope"})

vim.keymap.set("n", "<leader>C", "<cmd>desc<cr>", {desc = "Close tab"})

vim.keymap.set("n", "<leader>p", '"_ciw<esc>"*p', {desc = "Paste in word last yank"})

vim.keymap.set("n", "<F7>", '<cmd>CMakeBuild<cr>', {desc = "Cmake build"})
