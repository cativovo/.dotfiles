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
      ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[d]ocument', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[r]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[w]orkspace', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[t]oggle', _ = 'which_key_ignore' },
      ['<leader>g'] = git_keymaps,
    })
    -- visual mode
    wk.register({
      ['<leader>g'] = git_keymaps,
    }, { mode = 'v' })
  end,
}
