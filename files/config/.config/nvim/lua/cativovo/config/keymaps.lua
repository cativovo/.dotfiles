vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- clear highlight from hlsearch
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })

-- copy filepath
vim.keymap.set('n', '<leader>fya', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Copy absolute path' })
vim.keymap.set('n', '<leader>fyr', function()
  vim.fn.setreg('+', vim.fn.fnamemodify(vim.fn.expand('%'), ':.'))
end, { desc = 'Copy relative path' })
vim.keymap.set('n', '<leader>fyf', function()
  vim.fn.setreg('+', vim.fn.expand('%:t'))
end, { desc = 'Copy filename' })
vim.keymap.set('n', '<leader>fyb', function()
  local result = vim.fn.fnamemodify(vim.fn.expand('%'), ':.') .. ':' .. vim.fn.line('.')
  vim.fn.setreg('+', result)
end, { desc = 'Copy relative path with line number' })

-- copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy To Clipboard' })

-- workaround; can't remove <c-t> keymap, <c-t> is used in zellij
vim.keymap.set('n', '<c-t>', '<cmd>lua vim.api.nvim_err_writeln("Locked")<cr>')

-- quickfix list
vim.keymap.set('n', '<leader>qo', '<cmd>copen<cr>', { desc = 'Open Quickfix List' })
vim.keymap.set('n', '<leader>qc', '<cmd>cclose<cr>', { desc = 'Close Quickfix List' })
vim.keymap.set('n', '<A-j>', '<cmd>cnext<cr>', { desc = 'Next Item' })
vim.keymap.set('n', '<A-k>', '<cmd>cprev<cr>', { desc = 'Previous Item' })
