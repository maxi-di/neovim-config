return {
    {
        'jedrzejboczar/nvim-dap-cortex-debug',
        dependencies = {
            {
                "mfussenegger/nvim-dap",
                keys = {
                    {"<F5>",  function() require("dap").continue() end,          desc = "Run/Continue"},
                    {"<F6>",  function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint"},
                    {"<F9>",  function() require("dap").step_into() end,         desc = "Step Into"},
                    {"<F10>", function() require("dap").step_over() end,         desc = "Step Over"},
                    {"<F11>", function() require("dap").step_out() end,          desc = "Step Out"},
                },
            },
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    table.insert(opts.ensure_installed, "cortex-debug")
                end,
            },
            {
                "rcarriga/nvim-dap-ui",
                opts = function(_, opts)
                    vim.tbl_extend("force", opts, {
                        element_mappings = {
                            open = "<CR>",
                            expand = "o",
                        }
                    })
                end,
            },
        },
        config = function(_, opts)
            require("dap-cortex-debug").setup {
                debug = false, -- log debug messages
                -- path to cortex-debug extension, supports vim.fn.glob
                -- by default tries to guess: mason.nvim or VSCode extensions
                extension_path = nil,
                lib_extension = nil, -- shared libraries extension, tries auto-detecting, e.g. 'so' on unix
                node_path = 'node',  -- path to node.js executable
                dapui_rtt = true,    -- register nvim-dap-ui RTT element
                -- make :DapLoadLaunchJSON register cortex-debug for C/C++, set false to disable
                dap_vscode_filetypes = {'c', 'cpp'},
                rtt = {
                    buftype = 'Terminal', -- 'Terminal' or 'BufTerminal' for terminal buffer vs normal buffer
                },
            }
        end,
    }
}
