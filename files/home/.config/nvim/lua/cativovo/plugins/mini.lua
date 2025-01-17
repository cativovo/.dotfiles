local mini_surround_mappings = {
  add = 'gsa', -- Add surrounding in Normal and Visual modes
  delete = 'gsd', -- Delete surrounding
  find = 'gsf', -- Find surrounding (to the right)
  find_left = 'gsF', -- Find surrounding (to the left)
  highlight = 'gsh', -- Highlight surrounding
  replace = 'gsr', -- Replace surrounding
  update_n_lines = 'gsn', -- Update `n_lines`
}

return {
  {
    'echasnovski/mini.surround',
    keys = {
      { mini_surround_mappings.add, desc = 'Add Surrounding', mode = { 'n', 'v' } },
      { mini_surround_mappings.delete, desc = 'Delete Surrounding' },
      { mini_surround_mappings.find, desc = 'Find Right Surrounding' },
      { mini_surround_mappings.find_left, desc = 'Find Left Surrounding' },
      { mini_surround_mappings.highlight, desc = 'Highlight Surrounding' },
      { mini_surround_mappings.replace, desc = 'Replace Surrounding' },
      { mini_surround_mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
    },
    opts = {
      mappings = mini_surround_mappings,
    },
  },
  -- {
  --   'echasnovski/mini.ai',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter-textobjects',
  --   },
  --   opts = function()
  --     local ai = require('mini.ai')
  --     return {
  --       n_lines = 500,
  --       custom_textobjects = {
  --         o = ai.gen_spec.treesitter({ -- code block
  --           a = { '@block.outer', '@conditional.outer', '@loop.outer' },
  --           i = { '@block.inner', '@conditional.inner', '@loop.inner' },
  --         }),
  --         f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
  --         c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }), -- class
  --         t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
  --         d = { '%f[%d]%d+' }, -- digits
  --         e = { -- Word with case
  --           { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
  --           '^().*()$',
  --         },
  --         u = ai.gen_spec.function_call(), -- u for "Usage"
  --         U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
  --       },
  --       search_method = 'cover_or_nearest',
  --     }
  --   end,
  --   config = function(_, opts)
  --     require('mini.ai').setup(opts)
  --   end,
  -- },
}
