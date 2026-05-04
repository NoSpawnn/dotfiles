-- https://github.com/ej-shafran/compile-mode.nvim

return {
    "ej-shafran/compile-mode.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "m00qek/baleia.nvim", version = false }
    },
    config = function()
        vim.g.compile_mode = {
            bang_expansion = true,
            baleia_setup = true,
            focus_compilation_buffer = true,

            default_command = {
                rust = "cargo run",
            },

            error_regexp_table = {
                rustc = {
                    regex = [[^\s*-->\s*\([^:]\+\):\(\d\+\):\(\d\+\)]],
                    filename = 1,
                    row = 2,
                    col = 3,
                },
            },
        }
    end,
}
