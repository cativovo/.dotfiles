return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'williamboman/mason.nvim',
  },
  opts = function(_, opts)
    local nls = require('null-ls')
    opts.sources = vim.list_extend(opts.sources or {}, {
      -- go
      nls.builtins.code_actions.gomodifytags,
      nls.builtins.code_actions.impl,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.gofumpt,
    })
  end,
}
