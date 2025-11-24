return {
    {
        "hedyhli/markdown-toc.nvim",
        ft = "markdown", -- Lazy load on markdown filetype
        cmd = {"Mtoc"},  -- Or, lazy load on "Mtoc" command
        opts = {
            -- Your configuration here (optional)
            --
            -- Enable auto-update of the ToC (if fences found) on buffer save
            auto_update = true,
            toc_list = {},
        },
    },
}
