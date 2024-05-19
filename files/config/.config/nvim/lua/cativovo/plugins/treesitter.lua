return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'VeryLazy' },
  opts = {
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    local ensure_installed = { 'bash', 'diff', 'html', 'markdown', 'vim', 'vimdoc' }
    vim.list_extend(ensure_installed, require('cativovo.config.lang.go').parsers)
    vim.list_extend(ensure_installed, require('cativovo.config.lang.lua').parsers)
    opts.ensure_installed = ensure_installed

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.configs').setup(opts)
  end,
}
