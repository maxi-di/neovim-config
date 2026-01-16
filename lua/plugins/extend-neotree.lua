local function create_react_component(state)
    local node = state.tree:get_node()
    local base_path = node.type == "directory"
        and node.path
        or vim.fn.fnamemodify(node.path, ":h")

    vim.ui.input({prompt = "React component name: "}, function(name)
        if not name or name == "" then
            return
        end

        local dir = base_path .. "/" .. name
        local tsx = dir .. "/" .. name .. ".tsx"
        local css = dir .. "/" .. name .. ".module.css"

        -- создать папку
        vim.fn.mkdir(dir, "p")

        -- шаблон TSX
        local tsx_content = string.format(
            [[import styles from "./%s.module.css";

type Props = {};

function %s({}: Props) {
  return (
    <div className={styles.root}>
      %s
    </div>
  );
}

export default %s
]], name, name, name, name)

        -- записать файлы
        vim.fn.writefile(vim.split(tsx_content, "\n"), tsx)
        vim.fn.writefile({}, css)

        vim.cmd("edit " .. tsx)

        -- обновить дерево
        require("neo-tree.sources.manager").refresh("filesystem")

        vim.cmd("Neotree reveal_file=" .. tsx)
        vim.loop.new_timer():start(100, 0, vim.schedule_wrap(function()
            vim.cmd("Neotree reveal_file=" .. tsx)
        end))
    end)
end

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            filesystem = {
                follow_current_file = {
                    -- This will find and focus the file in the active buffer every time
                    -- the current file is changed while the tree is open.
                    enabled = false,
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                window = {
                    mappings = {
                        ["R"] = {create_react_component, desc = "Create React component folder",},
                    },
                }
            }
        },
        keys = {
            {
                "<leader>fn",
                function()
                    -- с первого раза только разворачивает папку,
                    -- но не фокусируется на конеретном файле
                    local file_name = vim.fn.expand("%")
                    vim.cmd("Neotree reveal_file=" .. file_name)
                    vim.loop.new_timer():start(100, 0, vim.schedule_wrap(function()
                        vim.cmd("Neotree reveal_file=" .. file_name)
                    end))
                end,
                desc = "Reveal current file"
            },
        },
    },
}
