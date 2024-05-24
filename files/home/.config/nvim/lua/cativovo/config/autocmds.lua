vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Save Folds
vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '?*',
  command = 'silent! mkview',
})
-- Load folds
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '?*',
  command = 'silent! loadview',
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  command = 'setlocal number',
})

vim.api.nvim_create_autocmd('FocusLost', {
  pattern = '*',
  command = 'setlocal nornu',
})

vim.api.nvim_create_autocmd('FocusGained', {
  pattern = '*',
  command = 'setlocal rnu',
})
