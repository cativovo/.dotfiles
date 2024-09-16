return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'svelte' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        svelte = {
          keys = {
            {
              '<leader>co',
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { 'source.organizeImports' },
                    diagnostics = {},
                  },
                })
              end,
              desc = 'Organize Imports',
            },
          },
          capabilities = {
            workspace = {
              didChangeWatchedFiles = vim.fn.has('nvim-0.10') == 0 and { dynamicRegistration = true },
            },
          },
        },
      },
    },
  },
  -- Configure tsserver plugin
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local utils = require('cativovo.utils')
      utils.extend(opts.servers.vtsls, 'settings.vtsls.tsserver.globalPlugins', {
        {
          name = 'typescript-svelte-plugin',
          location = utils.get_pkg_path('svelte-language-server', '/node_modules/typescript-svelte-plugin'),
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
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
      if has_prettier_config then
        opts.formatters_by_ft.svelte = { 'prettier' }
        return
      end

      opts.formatters_by_ft.svelte = { 'rustywind', lsp_format = 'first' }
    end,
  },
}
