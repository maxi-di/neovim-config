-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ct", "<cmd>Trouble telescope<cr>", {desc = "Trouble from telescope"})
vim.keymap.set("n", "<leader>x,", "<cmd>Trouble telescope<cr>", {desc = "Trouble from telescope"})

vim.keymap.set("n", "<leader>C", "<cmd>desc<cr>", {desc = "Close tab"})

vim.keymap.set("n", "<leader>p", '"_ciw<esc>"+p', {desc = "Paste in word last yank"})

vim.keymap.set("n", "<leader>sp",
    function() vim.notify("cwd: " .. vim.uv.cwd()) end,
    {desc = "Show current working directory"}
)

--- PICKERS

if vim.g.lazyvim_picker == "telescope" then
    vim.keymap.set("n", "<leader>g<C-b>", "<cmd>Telescope git_branches<CR>", {desc = "Branches"})
end

-- В lazyvim это есть, но почему-то комбинации не срабатывают
-- пришлось переобъявить здесь
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, {desc = "Icons"})
vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, {desc = "Undotree"})

vim.keymap.set("n", "<C-p>", LazyVim.pick("files", {root = false}), {desc = "Find Files (cwd)"})
vim.keymap.set("n", "<leader>s/", LazyVim.pick("live_grep", {search_dirs = {"%:p"}}), {desc = "Find Files (cwd)"})

vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", {desc = "Clang switch header/source file"})
