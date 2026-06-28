local vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.relativenumber = true

-- this is already in lualine
vim.opt.showmode = false

-- undo config
local undodir = vim.fn.stdpath("data") .. "/undodir"
if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir    = undodir
vim.opt.undofile   = true
vim.opt.swapfile   = false

-- indent settings: see https://gist.github.com/LunarLambda/4c444238fb364509b72cfb891979f1dd, these are way more confusing than they should be
vim.opt.expandtab  = true
vim.opt.smarttab   = true
vim.opt.shiftwidth = 4

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

-- quickfix list, i need to learn to use this properly
vim.keymap.set("n", "<leader>co", "<CMD>:copen<CR>")
vim.keymap.set("n", "<leader>cc", "<CMD>:cclose<CR>")

-- buffer keybinds
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprev<CR>")

-- yoinking some stuff from emacs
vim.keymap.set({ "n", "i" }, "<M-x>", "<ESC>:")
vim.keymap.set({ "n", "i" }, "<C-x><C-s>", "<ESC>:w<CR>")

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
vim.g.netrw_banner       = 0                           -- no banner
vim.g.netrw_liststyle    = 3                           -- tree style
vim.g.netrw_browse_split = 4                           -- always vertical
vim.g.netrw_keepdir      = 0                           -- change cwd as needed
vim.g.netrw_preview      = 1                           -- display in vertical split

vim.keymap.set("n", "<leader>fe", "<CMD>Explore<CR>")  -- take over window
vim.keymap.set("n", "<leader>fv", "<CMD>Lexplore<CR>") -- open in left split

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

require("telescope").setup({
    defaults = {
        layout_strategy = "vertical"
    },
})
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Telescope help tags" })

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

-- lsp
vim.lsp.enable({ "lua_ls", "clangd", "rust-analyzer" })
vim.diagnostic.config({ virtual_text = true })
vim.opt.completeopt:append("fuzzy,menuone,noselect,popup")
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method('textDocument/implementation') then
            vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float)

            if client:supports_method('textDocument/formatting') then
                vim.keymap.set(
                    { "n", "x" },
                    "<leader>lf",
                    function() vim.lsp.buf.format({ bufnr = ev.buf, id = client.id }) end
                )
            end
        end

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- theme
vim.cmd.colorscheme("industry")
require("lualine").setup({ options = { theme = "iceberg" } })
