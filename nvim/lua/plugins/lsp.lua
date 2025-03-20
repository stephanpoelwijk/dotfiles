return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function() 

    local mason = require('mason')
    local masonLspConfig = require('mason-lspconfig')
    local masonToolInstaller = require('mason-tool-installer')

    mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
    })

    masonLspConfig.setup({
			ensure_installed = {
        "csharp_ls",
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "lua_ls",
        "sqlls",
        "tailwindcss",
        "ts_ls",
        "yamlls",
			},
    })

    masonToolInstaller.setup({
			--  		ensure_installed = {
			-- 	"prettier", -- prettier formatter
			-- 	"stylua", -- lua formatter
			-- 	-- "black", -- python formatter,
			-- 	-- "pylint",
			-- 	"eslint_d",
			-- },
    })

  end,
}
