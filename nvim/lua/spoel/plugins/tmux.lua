return {
	"alexghergh/nvim-tmux-navigation",
	config = function()
		local nvim_tmux_nav = require("nvim-tmux-navigation")

		nvim_tmux_nav.setup({
			disable_when_zoomed = true, -- defaults to false
		})
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
		keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
		keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
		keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
		keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
		keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
	end,
}
