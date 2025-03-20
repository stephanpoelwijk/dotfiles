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
      mode = 'symbol',
      maxwidth = 50,
      show_labelDetails = true,
      ellipsis_char = "..."
    })

    local luaSnipCompletionOptions = {
      expand = function(args)
        luaSnip.lsp_expand(args)
      end
    }

    -- Set up the things
    cmp.setup({
      formatting = {
        snippet = luaSnipCompletionOptions,
        format = lspKindFormatOptions
      }
    })

  end
}
