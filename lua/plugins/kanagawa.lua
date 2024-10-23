return {
    {
        'rebelot/kanagawa.nvim',
        enabled = true,
        opts = function(_, opts)
            local c = require('kanagawa.colors').setup({theme = "wave"})
            opts.colors = {
                theme = {
                    wave = {
                        ui = {
                            nontext = c.palette.katanaGray,
                        },
                    }
                }
            }
        end,
    },

}
