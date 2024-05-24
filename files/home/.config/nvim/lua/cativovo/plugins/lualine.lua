return {
  {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'linrongbin16/lsp-progress.nvim',
        opts = {
          format = function(messages)
            if #messages > 0 then
              return ' LSP:' .. ' ' .. table.concat(messages, ' ')
            end

            local client_names = {}
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            for _, client in ipairs(clients) do
              if client and client.name ~= '' then
                table.insert(client_names, client.name)
              end
            end

            return ' LSP:' .. ' [' .. table.concat(client_names, ',') .. ']'
          end,
        },
      },
    },
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
    config = function()
      local icons = require('cativovo.config.icons')

      local opts = {
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
          lualine_x = {
            'filetype',
            function()
              return require('lsp-progress').progress()
            end,
          },
          lualine_y = {
            { 'progress' },
            { 'location' },
          },
          lualine_z = {
            function()
              return 'Lines: ' .. vim.fn.line('$')
            end,
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

      require('lualine').setup(opts)

      -- listen lsp-progress event and refresh lualine
      vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
      vim.api.nvim_create_autocmd('User', {
        group = 'lualine_augroup',
        pattern = 'LspProgressStatusUpdated',
        callback = require('lualine').refresh,
      })
    end,
  },
}
