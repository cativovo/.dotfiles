return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function(_, opts)
        local lint = require('lint')
        lint.linters.test = require('cativovo.utils.golangcilint')
        lint.linters_by_ft = vim.tbl_deep_extend('force', lint.linters_by_ft, opts.linters_by_ft)
        lint.linters_by_ft.go = { 'test' }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                if vim.bo.modifiable then
                    lint.try_lint()
                end
            end,
        })
    end,
}
