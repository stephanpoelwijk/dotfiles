local M = {}


local keymap = vim.keymap

-- Misc stuff
keymap.set("n", "<Esc", ":nohlsearch<CR>", { desc = "Clear search highlights" })




return M
