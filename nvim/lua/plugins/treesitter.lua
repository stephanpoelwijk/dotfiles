return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufEnter" },
    build = ":TSUpdate",
    dependencies = {},
    config = function()

      require("nvim-treesitter.configs").setup({

        ensure_installed = {
          "c_sharp",
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "sql",
          "swift",
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
