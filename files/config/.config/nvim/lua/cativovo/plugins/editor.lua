return {
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
  -- { 'numToStr/Comment.nvim', config = true },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
    init = function()
      vim.schedule(function()
        local get_option = vim.filetype.get_option
        vim.filetype.get_option = function(filetype, option)
          return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
        end
      end)
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
