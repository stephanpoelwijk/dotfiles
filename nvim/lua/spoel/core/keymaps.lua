-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- clear search highlights
keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- Obsidian
keymap.set("n", "<leader>on", function()
	local vaultInboxPath = vim.fn.expand("~/vaults/notes/_inbox")
	local vaultTemplateFileName = vim.fn.expand("~/vaults/notes/templates/newnote.md")

	local noteTimestamp = vim.fn.strftime("%Y-%m-%d_%H-%M")
	local file = io.open(vaultTemplateFileName, "r")
	local lines = {}
	-- table.insert(lines, "This is something from lua")
	vim.ui.input({ prompt = "New Note Title: " }, function(noteName)
		if noteName == nil then
			return
		end

		local tokens = {
			["NOTE_TITLE"] = noteName,
			["CURRENT_DATE"] = vim.fn.strftime("%Y-%m-%d"),
		}

		if file == nil then
			table.insert(lines, "Could not open template filename: " .. vaultTemplateFileName)
		else
			for line in file:lines() do
				for tokenKey, tokenValue in pairs(tokens) do
					line = line:gsub("{ " .. tokenKey .. " }", tokenValue)
				end
				table.insert(lines, line)
			end
		end

		local saferNoteFileName = string.lower(noteName:gsub("%s", "_"))

		-- print(string.lower(saferNoteFileName))
		vim.cmd.new(vaultInboxPath .. "/" .. noteTimestamp .. "_" .. saferNoteFileName .. ".md")
		local currentBuffer = vim.api.nvim_win_get_buf(0)
		local window = vim.api.nvim_get_current_win()
		local row, col = unpack(vim.api.nvim_win_get_cursor(window))

		vim.api.nvim_buf_set_lines(currentBuffer, row - 1, row - 1, false, lines)
	end)
end)

keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian Search " })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Some keybindings a la Visual Studio
keymap.set("n", "<leader>kr", "<cmd>Telescope lsp_references<CR>", { desc = "Show references" }) -- show definition, references
keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" }) -- smart rename
keymap.set("n", "<F12>", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definition" }) -- show lsp definitions
keymap.set("n", "<C-F12>", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" })

-- Other Windowsy things
keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

keymap.set("v", "<Tab>", ">gv", { desc = "Indent (Shift-Right)" })
keymap.set("v", "<S-Tab>", "<gv", { desc = "Un-indent (Shift-Left)" })

keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })
keymap.set({ "n", "v" }, "<F1>", vim.lsp.buf.code_action, { desc = "Show available code actions" }) -- see available code actions, in visual mode will apply to selection
