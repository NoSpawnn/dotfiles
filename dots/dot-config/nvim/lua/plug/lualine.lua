vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
})

-- this is already in the status line
vim.opt.showmode = false

require("lualine").setup({})
