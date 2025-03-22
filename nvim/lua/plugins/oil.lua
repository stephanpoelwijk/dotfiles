return {
	"stevearc/oil.nvim",
	---@module 'oil'
	opts = {
		delete_to_trash = false,
		view_options = {
			show_hidden = true,
		},
	},
	-- Optional dependencies
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", opts = {} },
	},
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
