-- Обрабатывае нажатия <C-a>/<C-x> инремент/декремент
return {
    "monaqa/dial.nvim",
    opts = function(_, opts)
        local augend = require("dial.augend")

        local new_opts = {
            dials_by_ft = {
                cpp = "cpp",
                cmake = "cmake",
                yaml = "yaml",
            },
            groups = {
                cpp = {},
                cmake = {},
                lua = {},
                yaml = {},
            }
        }
        opts = vim.tbl_deep_extend("force", opts, new_opts)

        vim.list_extend(opts.groups.default,
            {
                augend.constant.new {
                    elements = {"before", "after"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"add", "substract"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"disabled", "enabled"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"up", "down"},
                    word = true,
                    cyclic = true,
                    preserve_case = true,
                },
                augend.constant.new {
                    elements = {"ON", "OFF"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"start", "stop"},
                    word = true,
                    cyclic = true,
                    preserve_case = true,
                },
            }
        )

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
                augend.constant.new {
                    elements = {"==", ">=", "<=", "!="},
                    word = false,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"cerr", "cout"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"list", "vector"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"int8_t", "int16_t", "int32_t"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"uint8_t", "uint16_t", "uint32_t"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new {
                    elements = {"public", "private", "protected"},
                    word = true,
                    cyclic = true,
                },
            }
        )
        vim.list_extend(opts.groups.cmake,
            {
                augend.constant.new {
                    elements = {"PUBLIC", "PRIVATE"},
                    word = true,
                    cyclic = true,
                },
            }
        )
        vim.list_extend(opts.groups.lua,
            {
                augend.constant.new {
                    elements = {"trace", "debug", "info", "warn", "error", "fatal"},
                    word = true,
                    cyclic = true,
                },
            }
        )
        vim.list_extend(opts.groups.yaml,
            {
                augend.constant.new {
                    elements = {"trace", "debug", "info", "warn", "error", "fatal"},
                    word = true,
                    cyclic = true,
                },
            }
        )

        return opts
    end,
}
