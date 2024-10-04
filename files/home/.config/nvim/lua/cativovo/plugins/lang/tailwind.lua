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

          -- https://github.com/tailwindlabs/tailwindcss/discussions/5258#discussioncomment-9848843
          settings = {
            tailwindCSS = {
              lint = {
                invalidApply = false,
              },
            },
          },
        },
      },
      setups = {
        tailwindcss = function(opts)
          local tw = require('cativovo.utils.lsp').get_raw_config('tailwindcss')
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
      -- original kind icon formatter
      opts.formatting = opts.formatting or {}
      opts.formatting.format = function(entry, item)
        return require('tailwindcss-colorizer-cmp').formatter(entry, item)
      end
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'rustywind' })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local prettier_config_files = {
        '.prettierrc',
        '.prettierrc.json',
        '.prettierrc.yaml',
        '.prettierrc.yml',
        '.prettierrc.js',
        '.prettierrc.cjs',
        'prettier.config.js',
        'prettier.config.cjs',
        '.prettierrc.toml',
      }

      local has_prettier_config = require('cativovo.utils').root_has_file(prettier_config_files)
      if not has_prettier_config then
        return
      end

      local ft = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
        'css',
        'scss',
        'less',
        'html',
      }

      for _, v in ipairs(ft) do
        opts.formatters_by_ft[v] = opts.formatters_by_ft[v] or {}
        vim.list_extend(opts.formatters_by_ft[v], { 'rustywind' })
      end
    end,
  },
}
