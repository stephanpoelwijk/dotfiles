return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufEnter" },
    build = ":TSUpdate",
    dependencies = {},
    config = function()

      require("nvim-treesitter.configs").setup({

        ensure_installed = {
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "tsx",
          "typescript",
          "yaml"
        },
        sync_install = false,
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
        autopairs = {
          enable = true
        },
      })

    end

}
