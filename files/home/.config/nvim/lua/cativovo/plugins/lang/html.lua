vim.g.user_emmet_leader_key = '<C-x>'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'html',
      })
    end,
  },
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
    'mattn/emmet-vim',
    keys = {
      { '<C-x>', mode = { 'n', 'i', 'v' } },
    },
  },
}
