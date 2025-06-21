-- Обрабатывае нажатия <C-a>/<C-x> инремент/декремент
return {
    "monaqa/dial.nvim",
    opts = function(_, opts)
        local augend = require("dial.augend")

        local new_opts = {
            dials_by_ft = {
                cpp = "cpp",
            },
            groups = {
                cpp = {}
            }
        }
        opts = vim.tbl_deep_extend("force", opts, new_opts)

        vim.list_extend(opts.groups.cpp,
            {
                augend.constant.new {
                    elements = {"SPDLOG_TRACE", "SPDLOG_DEBUG", "SPDLOG_INFO", "SPDLOG_WARN", "SPDLOG_ERROR", "SPDLOG_CRITICAL"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"trace", "debug", "info", "warn", "error", "critical"},
                    word = true,
                    cyclic = true,
                },
            }
        )

        return opts
    end,
}
