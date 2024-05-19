return {
  'nvim-lualine/lualine.nvim',
  opts = function()
    local icons = require('cativovo.config.icons')

    return {
      options = {
        disabled_filetypes = { statusline = { 'lazy' } },
      },
      sections = {
        lualine_c = {
          {
            'grapple',
          },
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
        lualine_y = {
          { 'progress' },
          { 'location' },
        },
        lualine_z = {
          {
            function()
              return 'Lines: ' .. vim.fn.line('$')
            end,
          },
        },
      },
      winbar = {
        lualine_c = {
          { 'filename', path = 3, symbols = { modified = ' ' } },
        },
      },
      inactive_winbar = {
        lualine_c = {
          { 'filename', path = 3, symbols = { modified = ' ' } },
        },
      },
      extensions = {
        'lazy',
        'quickfix',
      },
    }
  end,
}
