return {
    "folke/noice.nvim",
    opts = {
        presets = {
            lsp_doc_border  = true, -- добавляет border ко всем LSP-доксам, включая hover
            bottom_search   = true,
            command_palette = {
                views = {
                    cmdline_popup = {
                        position = {
                            row = "50%",
                            col = "50%",
                        },
                        size = {
                            min_width = 60,
                            width     = "auto",
                            height    = "auto",
                        },
                    },
                },
            },
        },
    }
}
