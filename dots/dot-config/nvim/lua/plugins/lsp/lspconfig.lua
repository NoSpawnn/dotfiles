local configs = {
    clangd = {},
    lua_ls = {},
    rust_analyzer = {},

    -- nil is better for everything except completion
    nil_ls = {
        capabilities = { completionProvider = false }
    },
    nixd = {
        capabilities = {
            codeActionProvider = nil,
            definitionProvider = false,
            documentFormattingProvider = false,
            documentSymbolProvider = false,
            documentHighlightProvider = false,
            hoverProvider = false,
            inlayHintProvider = false,
            referencesProvider = false,
            renameProvider = false
        }
    }
}

return {
    "neovim/nvim-lspconfig",
    config = function()
        local configs_path = vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig/lsp"
        for ls, config in pairs(configs) do
            local path = configs_path .. "/" .. ls .. ".lua"
            if vim.loop.fs_stat(path) then
                vim.lsp.config(ls, config)
                vim.lsp.enable(ls)
            else
                local msg = ("nvim-lspconfig: bad server: '%s'. see %s for valid servers"):format(ls, configs_path)
                vim.notify(msg, vim.log.levels.WARN)
            end
        end
    end
}
