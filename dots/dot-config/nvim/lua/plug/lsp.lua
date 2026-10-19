vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig"
})

vim.diagnostic.config({ virtual_text = true })
vim.opt.completeopt = "fuzzy,menuone,noselect,popup"

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        local status, blink_cmp = pcall(require, "blink.cmp")
        if status then client.capabilities = blink_cmp.get_lsp_capabilities(client.capabilities) end

        vim.keymap.set("n", "<leader>q", function()
            vim.diagnostic.setqflist()
            vim.cmd([[ copen ]])
        end)

        if client:supports_method("textDocument/implementation") then
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float)
        end

        if client:supports_method("textDocument/formatting") then
            vim.keymap.set({ "n", "x" }, "<leader>lf", function()
                vim.lsp.buf.format({ bufnr = ev.buf, id = client.id })
            end)
        end

        if not blink_cmp and client:supports_method("textDocument/completion") then
            local chars = {}
            for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)
        end
    end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    }
})
vim.lsp.enable('lua_ls')
