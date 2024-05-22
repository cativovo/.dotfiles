return {
  'nvim-lualine/lualine.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = ' '
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local icons = require('cativovo.config.icons')

    return {
      options = {
        disabled_filetypes = { statusline = { 'lazy' } },
        globalstatus = true,
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
