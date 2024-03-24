require("mason").setup()
require("mason-lspconfig").setup { 
	ensure_installed = { "omnisharp", "lua_ls", "powershell_es", "yamlls" },
	automatic_installation = true
}

