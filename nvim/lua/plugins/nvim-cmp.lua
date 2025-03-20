return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind.nvim",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
  },
  config = function()

    local cmp = require('cmp')
    local lspKind = require('lspkind')
    local luaSnip = require('luasnip')

    -- Load snippets from VS Code
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Some objects to attempt to make things a bit more readable
    local lspKindFormatOptions = lspKind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      show_labelDetails = true,
      ellipsis_char = "...",
      menu = {
					nvim_lsp = "[LSP]",
					buffer = "[Buffer]",
					path = "[Path]",
					luasnip = "[Snippet]",
					nvim_lsp_signature_help = "[Signature]",
				}
    })

    local luaSnipCompletionOptions = {
      expandable_indicator = true,
      expand = function(args)
        luaSnip.lsp_expand(args)
      end
    }

    local windowOptions = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }

    -- Set up the things
    luaSnip.config.setup({})

    cmp.setup({
      completion = { completeopt = "menu,menuone,noinsert" },
      snippet = luaSnipCompletionOptions,
      window = windowOptions,
      sources = cmp.config.sources({
					{ name = "nvim_lsp", group_index = 1 }, -- lsp
					{ name = "buffer", max_item_count = 5, group_index = 2 }, -- text within current buffer
					{ name = "path", max_item_count = 3, group_index = 3 }, -- file system paths
					{ name = "luasnip", max_item_count = 3, group_index = 5 }, -- snippets
					{ name = "nvim-lsp-signature-help" },
				}),
      formatting = {
        format = lspKindFormatOptions
      }
    })

  end
}
