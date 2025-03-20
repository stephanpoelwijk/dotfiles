    return {
      'sainnhe/everforest',
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.everforest_enable_italic = false
        vim.g.everforest_disable_italic_comment = true
        vim.g.everforest_background = 'medium'
        vim.cmd.colorscheme('everforest')
      end
    }
