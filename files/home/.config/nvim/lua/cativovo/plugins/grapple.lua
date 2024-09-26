return {
  'cbochs/grapple.nvim',
  cmd = 'Grapple',
  config = true,
  keys = {
    { '<leader>fa', '<cmd>Grapple tag<cr>', desc = 'tag a file' },
    { '<leader>fm', '<cmd>Grapple toggle_tags<cr>', desc = 'toggle tags menu' },
    { '<leader>fj', '<cmd>Grapple select index=1<cr>', desc = 'select first tag' },
    { '<leader>fk', '<cmd>Grapple select index=2<cr>', desc = 'select second tag' },
    { '<leader>fl', '<cmd>Grapple select index=3<cr>', desc = 'select third tag' },
    { '<leader>f;', '<cmd>Grapple select index=4<cr>', desc = 'select fourth tag' },
    { '<leader>fu', '<cmd>Grapple select index=5<cr>', desc = 'select fifth tag' },
    { '<leader>fi', '<cmd>Grapple select index=6<cr>', desc = 'select sixth tag' },
    { '<leader>fo', '<cmd>Grapple select index=7<cr>', desc = 'select seventh tag' },
    { '<leader>fp', '<cmd>Grapple select index=8<cr>', desc = 'select eighth tag' },
  },
}
