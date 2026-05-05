local configs = {
    clangd = {},
    lua_ls = {},
    rust_analyzer = {},
    powershell_es = {
        cmd = function(dispatchers)
            local temp_path = vim.fn.stdpath('cache')

            local command = ("powershell-editor-services -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es.session.json' -HostName nvim -Stdio -LogLevel Information")
            :format(temp_path, temp_path)

            return vim.lsp.rpc.start(vim.split(command, " "), dispatchers)
        end
    },

    -- nil is better for everything except completion
    nil_ls = {
        capabilities = { textDocument = { completionProvider = nil } }
    },
    nixd = {
        capabilities = {
            textDocument = {
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
