local vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.relativenumber = true
vim.opt.exrc = true

-- undo config
local undodir = vim.fn.stdpath("data") .. "/undodir"
if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir    = undodir
vim.opt.undofile   = true
vim.opt.swapfile   = false

-- indent settings: see https://gist.github.com/LunarLambda/4c444238fb364509b72cfb891979f1dd, these are way more confusing than they should be
vim.opt.expandtab   = true
vim.opt.smarttab    = true
vim.opt.shiftwidth  = 4
vim.opt.smartindent = true

-- better search
vim.opt.hlsearch   = true
vim.opt.incsearch  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.wildoptions:append("fuzzy") -- better completion with fuzzy search

-- prefer vsplits below
vim.opt.splitbelow = true

-- always show sign gutter col to avoid text jumping left and right
vim.opt.signcolumn = "yes"

-- display certain whitespace
vim.opt.listchars  = "trail:~,tab:>-"
vim.opt.list       = true

-- use system clipboard
vim.opt.clipboard  = "unnamedplus"

-- clear last / search with escape
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch | let @/ = ''<CR>", { silent = true })

-- quickfix list, I need to learn to use this properly
vim.keymap.set("n", "<leader>co", "<CMD>:copen<CR>")
vim.keymap.set("n", "<leader>cc", "<CMD>:cclose<CR>")

-- buffer keybinds
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprev<CR>")

-- don't yank with x
vim.keymap.set("n", "x", "\"_x")

-- yoinking some stuff from emacs
vim.keymap.set({ "n", "i" }, "<M-x>", "<ESC>q:") -- use the command buffer moar
vim.keymap.set({ "n", "i" }, "<C-x><C-s>", "<ESC>:w<CR>")

-- emacs-like describe
vim.api.nvim_create_user_command(
    "Describe",
    function()
        local word = vim.fn.expand("<cword>")
        if word ~= "" then vim.cmd.help(word) end
    end,
    { desc = "Show help of symbol at cursor", force = true }
)

-- netrw
vim.g.netrw_banner       = 0  -- no banner
vim.g.netrw_liststyle    = 3  -- tree style
vim.g.netrw_browse_split = 4  -- always vertical
vim.g.netrw_keepdir      = 0  -- change cwd as needed

vim.keymap.set("n", "<leader>fe", "<CMD>Explore<CR>")  -- take over window
vim.keymap.set("n", "<leader>fv", "<CMD>Lexplore<CR>") -- open in left split

-- plugins
require("plug")

-- snippets/abbreviations
require("snippets")

-- theme
vim.cmd.colorscheme("industry")

