return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    local wk = require('which-key')
    wk.setup()
    local git_keymap = {
      { '<leader>g', group = 'git' },
      { '<leader>gh', group = 'hunk' },
    }
    local file_keymap = {
      { '<leader>f', group = 'file' },
      { '<leader>fy', group = 'copy' },
    }

    local normal_keymaps = {
      { '<leader>c', group = 'code' },
      { '<leader>d', group = 'document/debugger' },
      { '<leader>s', group = 'search' },
      { '<leader>w', group = 'workspace' },
      { '<leader>t', group = 'toggle' },
      { '<leader>q', group = 'quickfixlist' },
    }

    normal_keymaps = vim.tbl_extend('force', normal_keymaps, git_keymap, file_keymap)

    wk.add(normal_keymaps)

    -- visual mode
    local visual_keymaps = vim.tbl_extend('force', { mode = 'v' }, git_keymap, file_keymap)

    wk.add(visual_keymaps)
  end,
}
