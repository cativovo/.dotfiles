return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'html',
      })
    end,
    {
      'neovim/nvim-lspconfig',
      opts = {
        servers = {
          html = {
            filetypes = { 'html', 'javascriptreact', 'typescriptreact' },
          },
        },
      },
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { 'emmet-language-server' })
      end,
    },
  },
}
