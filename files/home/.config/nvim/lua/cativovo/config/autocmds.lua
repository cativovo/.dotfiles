vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

local folds = vim.api.nvim_create_augroup('folds', { clear = true })
-- Save Folds
vim.api.nvim_create_autocmd('BufWinLeave', {
    group = folds,
    pattern = '?*',
    command = 'silent! mkview',
})
-- Load folds
vim.api.nvim_create_autocmd('BufReadPost', {
    group = folds,
    pattern = '?*',
    command = 'silent! loadview',
})

local focus = vim.api.nvim_create_augroup('focus', { clear = true })
vim.api.nvim_create_autocmd('FocusLost', {
    group = focus,
    pattern = '*',
    command = 'setlocal nornu',
})
vim.api.nvim_create_autocmd('FocusGained', {
    group = focus,
    pattern = '*',
    command = 'setlocal rnu',
})
