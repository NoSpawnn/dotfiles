-- https://github.com/ej-shafran/compile-mode.nvim

return {
    "ej-shafran/compile-mode.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim", },
    config = function()
        vim.g.compile_mode = {
            bang_expansion = true,
            focus_compilation_buffer = false,
            default_command = {
                rust = "cargo run"
            },
            error_regexp_table = {
                rustc = {
                    regex = [[^\s*-->\s*\([^:]\+\):\(\d\+\):\(\d\+\)]],
                    filename = 1,
                    row = 2,
                    col = 3,
                },
            }
        }
    end
}
