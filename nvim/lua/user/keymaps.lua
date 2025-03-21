local M = {}

local keymap = vim.keymap

-- Misc stuff
keymap.set("n", "<Esc", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Telescope
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Oil
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Utilities
keymap.set("n", "<leader>lg", "<CMD>LazyGit<CR>", { desc = "Open LazyGit" })
keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = true })
end, { desc = "Local keymaps (which-key)" })

return M
