return {
    {
        'dkarter/bullets.vim',
        ft = {'markdown', 'text'},
        config = function()
            vim.g.bullets_enabled_file_types = {'markdown', 'text'}
            vim.g.bullets_outline_levels = {'num'} -- Поддержка нумерованных списков
        end,
    }
}
