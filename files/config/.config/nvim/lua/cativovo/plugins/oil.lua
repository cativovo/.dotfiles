return {
  'stevearc/oil.nvim',
  cmd = 'Oil',
  keys = {
    {
      '<leader>e',
      '<cmd>Oil<cr>',
      desc = 'oil',
    },
  },
  config = true,
  opts = {
    -- https://github.com/stevearc/oil.nvim#options
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<C-s>'] = false,
      ['<C-t>'] = false,
      ['|'] = 'actions.select_vsplit',
      ['<leader>-'] = 'actions.select_split',
      ['<leader>r'] = 'actions.refresh',
      ['<leader>fya'] = {
        callback = function()
          local oil = require('oil')
          local entry = oil.get_entry_on_line(0, vim.fn.line('.'))
          vim.fn.setreg('+', oil.get_current_dir() .. entry.name)
        end,
        desc = 'Copy absolute path',
        mode = 'n',
      },
      ['<leader>fyr'] = {
        callback = function()
          local oil = require('oil')
          local entry = oil.get_entry_on_line(0, vim.fn.line('.'))
          vim.fn.setreg('+', vim.fn.fnamemodify(oil.get_current_dir() .. entry.name, ':.'))
        end,
        desc = 'Copy relative path',
        mode = 'n',
      },
      ['<leader>fyf'] = {
        callback = function()
          local oil = require('oil')
          local entry = oil.get_entry_on_line(0, vim.fn.line('.'))
          vim.fn.setreg('+', entry.name)
        end,
        desc = 'Copy file/directory name',
        mode = 'n',
      },
    },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
