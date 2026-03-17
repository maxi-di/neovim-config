-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt


opt.shiftwidth = 4 -- Size of an indent
opt.tabstop    = 4 -- Number of spaces tabs count for
opt.wrap       = true

-- когда отображаешь файл в режиме diff, то удаленные места по умолчанию
-- отображались плиткой из символов `/`, это сильно режет глаза
opt.fillchars  = {
    diff = " ",
}

-- чтобы при нажатии <w> курсор не останавливался на символе "-" в середине слова
-- opt.iskeyword:append("-")


-- чтобы не появлялось окно 'no name' при открытии nvim
-- из-за этой опции если буфер уже загружен и я его открываю через, например telescope
-- то курсор всегда переходит в начало файла, неудобно
-- vim.cmd("set nohidden")

-- плавная прокрутка на <C-d>/<C-u>
vim.g.snacks_animate = false

-- vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_picker = "fzf"

-- "saghen/blink.cmp" - использовать самую свежую версию из main ветки
-- FIXME: убрать в false 1 июня 2026
vim.g.lazyvim_blink_main = true
