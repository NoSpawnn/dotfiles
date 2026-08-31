local vim = vim

-- to get this to work the first time:
--      1. touch dots/dot-config/quickshell/.qmlls.ini
--      2. run quickshell (`qs` script from devenv), which populates the above file
vim.lsp.config("qmlls", { root_markers = { "shell.qml" }, command = { "qmlls", "-E" } })
vim.lsp.enable("qmlls")
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		qml = { "qmlformat" },
	},
	format_on_save = true,
})
