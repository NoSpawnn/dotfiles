vim.pack.add({
    "https://github.com/lewis6991/gitsigns.nvim",
})

require("gitsigns").setup({
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '?' },
  },
  signs_staged = {
    add          = { text = 'S+' },
    change       = { text = 'S~' },
    delete       = { text = 'S_' },
    topdelete    = { text = 'S‾' },
    changedelete = { text = 'S~' },
    untracked    = { text = 'S?' },
  },
})
