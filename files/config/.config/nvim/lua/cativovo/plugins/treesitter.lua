return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'VeryLazy' },
    opts = {
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
            -- You can also use captures from other query groups like `locals.scm`
            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
      },
    },
    config = function(_, opts)
      local ensure_installed = { 'bash', 'diff', 'html', 'markdown', 'vim', 'vimdoc' }
      vim.list_extend(ensure_installed, require('cativovo.config.lang.go').parsers)
      vim.list_extend(ensure_installed, require('cativovo.config.lang.lua').parsers)
      opts.ensure_installed = ensure_installed

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { 'VeryLazy' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'VeryLazy' },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { link = 'Cursorline' })
      vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { link = 'Cursorline' })
      require('treesitter-context').setup(opts)
    end,
    opts = {
      max_lines = 6,
    },
  },
}
