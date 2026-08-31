vim.pack.add({"github.com/neovim/nvim-lspconfig"})

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

            if client:supports_method('textDocument/completion') then
                vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            end
        end
    end,
})
