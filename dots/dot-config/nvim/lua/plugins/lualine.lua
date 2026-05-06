-- https://github.com/nvim-lualine/lualine.nvim

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        tabline = {
            lualine_z = { 'buffers' }
        }
    },
}
