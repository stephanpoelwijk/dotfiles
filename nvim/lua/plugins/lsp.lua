return {

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
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

			-- Map keys when LSP attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					require("user.keymaps").map_lsp_keys(ev.buffer)
				end,
			})

			-- Lsp configuration
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			masonLspConfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						-- settings = {},
					})
				end,
				["csharp_ls"] = function()
					lspconfig["csharp_ls"].setup({
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						},
					})
				end,
				["tailwindcss"] = function()
					lspconfig["tailwindcss"].setup({
						capabilities = capabilities,
						filetypes = { "typescriptreact", "javascriptreact", "html" },
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
			local stringUtil = require("usermodules.stringutil")

			vim.api.nvim_create_user_command("FormatDocument", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					["_"] = function()
						local fileName = vim.fn.expand("%")
						if stringUtil.starts_with(fileName, "oil:") or stringUtil.ends_with(fileName, "\\.cs") then
							print("Skipping formatting for " .. fileName)
							return {}
						end

						return { "prettier" }
					end,
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters = {
					prettier = {
						prepend_args = function()
							local extension = vim.fn.expand("%:e")
							if extension == "tsx" then
								return { "--single-quote", "--bracket-same-line", "--tab-width", "2" }
							else
								return {}
							end
						end,
					},
				},
			})
		end,
	},
}
