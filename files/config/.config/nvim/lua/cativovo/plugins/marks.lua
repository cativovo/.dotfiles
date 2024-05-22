return {
  'chentoast/marks.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local marks = require('marks')
    vim.keymap.set('n', 'm', marks.set, { desc = 'sets a letter mark (will wait for input)' })
    vim.keymap.set('n', 'dm', marks.delete, { desc = 'delete a letter mark (will wait for input)' })
    vim.keymap.set('n', 'dm<space>', marks.delete_buf, { desc = 'deletes all marks in current buffer.' })
    vim.keymap.set('n', '<leader>qm', '<cmd>MarksQFListBuf<cr>', { desc = 'extract marks to quickfix' })

    require('marks').setup({
      default_mappings = false,
      refresh_interval = 300,
    })
  end,
}
