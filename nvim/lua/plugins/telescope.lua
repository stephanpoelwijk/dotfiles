return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")
		-- local actions = require("telescope.actions")

		telescope.setup({
			pickers = {
				live_grep = {
					file_ignore_patterns = { "node_modules", ".git/", ".venv" },
					additional_args = function(_)
						return { "--hidden" }
					end,
				},
				find_files = {
					file_ignore_patterns = {
						"^.git/",
					},
					hidden = true,
				},
			},
			extensions = { "fzf" },
		})

		telescope.load_extension("fzf")
	end,
}
