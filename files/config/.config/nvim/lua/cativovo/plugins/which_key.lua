return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    local wk = require('which-key')
    wk.setup()
    local git_keymaps = {
      name = 'git',
      _ = 'which_key_ignore',
      h = { name = 'hunk', _ = 'which_key_ignore' },
    }

    wk.register({
      ['<leader>c'] = { name = 'code', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = 'document', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = 'rename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = 'search', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = 'workspace', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = 'toggle', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = 'file', _ = 'which_key_ignore' },
      ['<leader>g'] = git_keymaps,
    })
    -- visual mode
    wk.register({
      ['<leader>g'] = git_keymaps,
    }, { mode = 'v' })
  end,
}
