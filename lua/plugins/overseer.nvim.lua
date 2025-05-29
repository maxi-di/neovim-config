return {
    {
        "stevearc/overseer.nvim",
        dependencies = {
            "akinsho/toggleterm.nvim",
            {
                "folke/which-key.nvim",
                opts = {
                    defaults = {},
                    spec = {
                        {
                            {"<leader>r", group = "run tasks"},
                        }
                    }
                }
            },
        },
        opts = function(_, opts)

            vim.api.nvim_create_user_command("OverseerRestartLast", function()
                local overseer = require("overseer")
                local tasks = overseer.list_tasks({recent_first = true})
                if vim.tbl_isempty(tasks) then
                    vim.notify("No last tasks found", vim.log.levels.WARN)
                else
                    overseer.run_action(tasks[1], "restart")
                end
            end, {})

            vim.api.nvim_create_user_command("OverseerDisposeAllTasks", function()
                local overseer = require("overseer")
                local tasks = overseer.list_tasks({recent_first = true})
                if vim.tbl_isempty(tasks) then
                    vim.notify("No tasks found", vim.log.levels.WARN)
                else
                    for _, task in ipairs(tasks) do
                        overseer.run_action(task, "dispose")
                    end
                end
            end, {})

            opts = {
                -- strategy = nil, -- "toggleterm"
                -- strategy = {"toggleterm"},
            }
            return opts
        end,
        keys = {
            {"<leader>ol", "<cmd>OverseerRestartLast<cr>",     desc = "Restart last task"},
            {"<leader>oT", "<cmd>OverseerToggle<cr>",          desc = "Show tasks output"},
            {"<leader>oD", "<cmd>OverseerDisposeAllTasks<cr>", desc = "Dispose all tasks"},
        }
    }
}
