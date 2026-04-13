return {
	"stevearc/conform.nvim",

	-- @module "conform"
	-- @type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt", lsp_format = "fallback" },
		},
		format_on_save = { timeout_ms = 500 },
	},
}
