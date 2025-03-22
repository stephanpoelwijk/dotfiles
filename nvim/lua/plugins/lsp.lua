return {

	{
		"neovim/nvim-lspconfig",
		-- event = { "BufReadPre", "BufNewFile" },
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

			local function dump(o)
				if type(o) == "table" then
					local s = "{ "
					for k, v in pairs(o) do
						if type(k) ~= "number" then
							k = '"' .. k .. '"'
						end
						s = s .. "[" .. k .. "] = " .. dump(v) .. ","
					end
					return s .. "} "
				else
					return tostring(o)
				end
			end

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
			-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
			-- local capabilities = cmp_nvim_lsp.default_capabilities()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- print(dump(capabilities))

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
						-- handlers = {
						-- 	["textDocument/signatureHelp"] = function()
						-- 		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
						-- 	end,
						-- },
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
					cs = { "csharpier" },
					["_"] = { "prettier" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters = {
					prettier = {
						prepend_args = function()
							--							local filetype = conform.get_matching_filetype(buf)
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
