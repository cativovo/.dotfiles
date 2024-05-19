return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    'lukas-reineke/indent-blankline.nvim',
    config = true,
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          'help',
          'lazy',
          'mason',
        },
      },
    },
    -- See `:help ibl`
    main = 'ibl',
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', config = true },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
