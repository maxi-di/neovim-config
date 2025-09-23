return {
    {
        "ibhagwan/fzf-lua",
        opts = function(_, opts)
            opts.previewers = {
                builtin = {
                    snacks_image = {enabled = false, render_inline = false},
                },
            }
            return opts
        end,
    },
}
