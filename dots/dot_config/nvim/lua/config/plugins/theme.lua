return {
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
		config = function()
			require("tokyodark").setup({
				transparent = true,
			}) -- calling setup is optional
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "cool",
				transparent = true,
			})
			require("onedark").load()
		end,
	},
}
