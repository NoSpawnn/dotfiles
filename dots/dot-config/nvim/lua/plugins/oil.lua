-- https://github.com/stevearc/oil.nvim

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
        { "<leader>fo", "<cmd>Oil<CR>", desc = "Oil" }
    },
	opts = {
		columns = {
			"icon",
			"permissions",
			"size",
			"mtime",
		},
		view_options = {
			show_hidden = true,
		},
	},
}
