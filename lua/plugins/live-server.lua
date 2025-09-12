local root_dir = function(fname)
    return require("lspconfig.util").root_pattern(
        ".git",
        ".root",
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
    )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
        fname
    ) or require("lspconfig.util").find_git_ancestor(fname)
end

return {
    {
        'barrett-ruth/live-server.nvim',
        -- Это нужно установить заранее
        -- build = 'sudo npm install -g live-server',
        cmd = {'LiveServerStart', 'LiveServerStop'},
        config = true,
        keys = {
            {"<F4>", string.format("<cmd>LiveServerStart %s<cr>", root_dir(vim.fn.expand("%:p"))), desc = "Live server start"},
        },
    }
}
