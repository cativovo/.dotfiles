return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    local wk = require('which-key')
    wk.setup()
    local git_keymaps = {
      name = '[G]it',
      _ = 'which_key_ignore',
      h = { name = '[h]unk', _ = 'which_key_ignore' },
    }

    wk.register({
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      ['<leader>g'] = git_keymaps,
    })
    -- visual mode
    wk.register({
      ['<leader>g'] = git_keymaps,
    }, { mode = 'v' })
  end,
}
