return {
    'nvimtools/none-ls.nvim',
    dependencies = { 'mason.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function(_, opts)
        opts.root_dir = opts.root_dir or require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git')

        local null_ls = require('null-ls')
        opts.sources = opts.sources or {}
        null_ls.setup({ sources = opts.sources })
    end,
}
