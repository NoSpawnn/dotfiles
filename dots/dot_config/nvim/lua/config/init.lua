vim.g.mapleader = " "

require("config.set")
require("config.lazy_init")
require("config.lsp")

vim.cmd([[ colorscheme onedark ]])
