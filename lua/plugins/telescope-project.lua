-- require'telescope'.extensions.project.project{}
return {
    {
        "nvim-telescope/telescope-project.nvim",
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                {
                    "nvim-telescope/telescope-project.nvim",
                    config = function()
                        LazyVim.on_load("telescope.nvim", function()
                            require("telescope").load_extension("project")
                        end)
                    end,
                },
            },
            keys = {
                {
                    "<leader>P",
                    function()
                        require(
                            "telescope"
                        ).extensions.project.project()
                    end,
                    desc = "Open telescope project's",
                },
            },
        }
    },
}
