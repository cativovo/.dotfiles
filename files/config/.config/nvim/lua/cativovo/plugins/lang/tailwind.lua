return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { 'markdown' },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
      },
      setups = {
        tailwindcss = function(opts)
          local tw = require('lspconfig.server_configurations.tailwindcss')
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },
    },
    opts = function(_, opts)
      vim.print(opts)
      -- original kind icon formatter
      opts.formatting = opts.formatting or {}
      opts.formatting.format = function(entry, item)
        return require('tailwindcss-colorizer-cmp').formatter(entry, item)
      end
    end,
  },
}
