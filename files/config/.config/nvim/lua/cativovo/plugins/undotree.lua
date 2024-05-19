return {
  'mbbill/undotree',
  cmd = { 'UndotreeToggle' },
  config = function()
    vim.g.undotree_CustomUndotreeCmd = 'topleft vertical 30 new'
    vim.g.undotree_CustomDiffpanelCmd = 'botright 10 new'
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
  keys = {
    { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'toggle undo tree' },
  },
}
