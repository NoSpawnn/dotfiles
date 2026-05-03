vim.cmd [[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method("textDocument/implementation") then
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
            vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = "List workspace symbols" })
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Float diagnostics" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
            vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { desc = "Code action" })
            vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { desc = "Find references" })
            vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "Rename symbol" })
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })
            vim.keymap.set("n", "<leader>vf", function()
                vim.lsp.buf.format({ bufnr = ev.buf, id = client.id })
            end, { desc = "Format document" })
        end

        if client:supports_method("textDocument/completion") then
            local chars = {}
            for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
}
)

return {}
