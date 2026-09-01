vim.pack.add({
    "github.com/nvim-tree/nvim-web-devicons",
    "github.com/nvim-lualine/lualine.nvim",
})

-- this is already in the status line
vim.opt.showmode = false

require("lualine").setup({
    options = {
        theme = "iceberg",
    },
})
