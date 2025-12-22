-- vim.lsp.set_log_level("debug")

vim.lsp.enable({
	"cssls",
	"eslint",
	"emmet_ls",
	"html",
	"jsonls",
	"yamlls",
	"lua_ls",
	"csharp_ls",
	"ts_ls",
	"tailwindcss",
})

-- Map keys when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		require("user.keymaps").map_lsp_keys(ev.buffer)
	end,
})

require("mason").setup({})
