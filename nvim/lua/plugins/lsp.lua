return {

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local mason = require("mason")
			local masonLspConfig = require("mason-lspconfig")
			local masonToolInstaller = require("mason-tool-installer")

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

			-- Lsp configuration
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities()

			masonLspConfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
}
