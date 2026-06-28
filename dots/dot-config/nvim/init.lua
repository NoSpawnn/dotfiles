local vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd.colorscheme("industry")

vim.opt.relativenumber = true

-- undo config
local undodir = vim.fn.stdpath("data") .. "/undodir"
if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.undofile = true
vim.opt.swapfile = false

-- indent settings: see https://gist.github.com/LunarLambda/4c444238fb364509b72cfb891979f1dd, these are way more confusing than they should be
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4

-- better search
vim.opt.hlsearch       = true
vim.opt.incsearch      = true
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.wildoptions:append("fuzzy") -- better completion with fuzzy search

-- prefer vsplits below
vim.opt.splitbelow     = true

-- display certain whitespace
vim.opt.listchars = "trail:~,tab:>-"
vim.opt.list = true


-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- clear last / search with escape
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch | let @/ = ''<CR>", { silent = true, noremap = true })

-- buffer keybinds
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", {})

-- alt-x for :
vim.keymap.set("n", "<M-x>", ":", { noremap = true })
vim.keymap.set("i", "<M-x>", "<ESC>:", { noremap = true })

-- emacs-like describe
vim.api.nvim_create_user_command(
    "Describe",
    function()
        local word = vim.fn.expand("<cword>")
        if word == "" then return end
        vim.cmd.help(word)
    end,
    { desc = "Show help of symbol at cursor", force = true }
)

-- netrw
vim.g.netrw_banner = 0       -- no banner
vim.g.netrw_liststyle = 3    -- tree style
vim.g.netrw_browse_split = 4 -- always vertical
vim.g.netrw_keepdir = 0      -- change cwd as needed
vim.g.netrw_preview = 1      -- display in vertical split

vim.keymap.set("n", "<leader>fee", "<CMD>Explore<CR>")  -- take over window
vim.keymap.set("n", "<leader>fev", "<CMD>Lexplore<CR>") -- open in left split

-- plugins
vim.pack.add({
    "github.com/nvim-tree/nvim-web-devicons",
    "github.com/nvim-lualine/lualine.nvim",
    "github.com/nvim-lua/plenary.nvim",
    "github.com/nvim-telescope/telescope.nvim",
    "github.com/hiphish/rainbow-delimiters.nvim",
    "github.com/neovim/nvim-lspconfig",
    "github.com/nospawnn/align.nvim"
})

require("lualine").setup({ options = { theme = "16color" } })

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep,  { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers,    { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags,  { desc = "Telescope help tags" })

-- snippets/abbreviations
for name, body in pairs({
    lgtm = "looks good to me"
}) do vim.cmd.iabbrev(name, body) end

for ft, abbrs in pairs({
    lua = {
        req = "require(\"\").setup({})<ESC>2F(la",
        kms = "vim.keymap.set(\"\", \"\", , {})<ESC>F(la"
    },
    cpp = {
        fmain = "int main() {<CR>}<ESC>Oreturn;<ESC>hi"
    }
}) do
    if next(abbrs) ~= nil then
        for name, body in pairs(abbrs) do
            vim.api.nvim_create_autocmd(
                "FileType",
                {
                    pattern = ft,
                    callback = function() vim.cmd.inoreabbrev("<buffer> " .. name, body) end
                }
            )
        end
    end
end

-- a sprinkle of lsp
vim.lsp.enable({ "lua_ls", "clangd" })
