return {
    "neovim/nvim-lspconfig",
    config = function()
        local to_enable = {
            "clangd",
            "lua_ls",
            "rust_analyzer",
            "nil_ls"
        }

        local configs_path = vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig/lsp"
        for _, ls in ipairs(to_enable) do
            local path = configs_path .. "/" .. ls .. ".lua"
            if not vim.loop.fs_stat(path) then
                vim.notify(("nvim-lspconfig: bad server: '%s'. see %s for valid servers"):format(ls, configs_path),
                    vim.log.levels.WARN)
            end
        end

        vim.lsp.enable(to_enable)
    end
}
