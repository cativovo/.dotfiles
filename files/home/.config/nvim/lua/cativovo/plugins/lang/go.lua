return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'go',
        'gomod',
        'gowork',
        'gosum',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
              semanticTokens = true,
            },
          },
        },
      },
      setups = {
        gopls = function()
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          require('cativovo.utils').on_lsp_attach(function(client)
            if client.name == 'gopls' then
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end
          end, 'gopls')
          -- end workaround
        end,
      },
    },
  },
  -- Ensure Go tools are installed
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'goimports', 'gofumpt' })
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    ft = 'go',
    dependencies = {
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'gomodifytags', 'impl', 'golangci-lint' })
        end,
      },
    },
    opts = function(_, opts)
      local nls = require('null-ls')
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.code_actions.impl,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.gofumpt,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        go = { 'goimports', 'gofumpt' },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        go = { 'golangcilint' },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'delve' })
        end,
      },
      {
        'leoluz/nvim-dap-go',
        config = function()
          local delve = {}

          -- workaround to set custom port per project
          -- .dlv.config example
          -- port=6969
          -- https://github.com/leoluz/nvim-dap-go/blob/5faf165f5062187320eaf9d177c3c1f647adc22e/lua/dap-go.lua#L10
          local filepath = '.dlv.config'
          if vim.fn.filereadable(filepath) == 1 then
            for line in io.lines(filepath) do
              local words = {}
              for word in string.gmatch(line, '[^=]+') do
                table.insert(words, word)
              end
              delve[words[1]] = words[2]
            end
          end

          local opts = {
            delve = delve,
          }
          require('dap-go').setup(opts)
        end,
      },
    },
  },
}
