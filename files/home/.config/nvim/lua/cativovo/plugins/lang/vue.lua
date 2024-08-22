return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'vue' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
          -- https://github.com/tailwindlabs/tailwindcss/discussions/5258#discussioncomment-9848843
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = 'ignore',
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = 'ignore',
              },
            },
          },
        },
        vtsls = {},
      },
    },
  },
  -- Configure tsserver plugin
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      table.insert(opts.servers.vtsls.filetypes, 'vue')
      local utils = require('cativovo.utils')
      utils.extend(opts.servers.vtsls, 'settings.vtsls.tsserver.globalPlugins', {
        {
          name = '@vue/typescript-plugin',
          location = utils.get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
          languages = { 'vue' },
          configNamespace = 'typescript',
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },
}
