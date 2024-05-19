local grep_opts = {
  additional_args = {
    '--hidden',
  },
}

-- for lsp_symbols pickers
local symbol_width = 60

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- If encountering errors, see telescope-fzf-native README for installation instructions
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',
      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { '.git/' },
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            preview_cutoff = 0,
            prompt_position = 'top',
            mirror = true,
            preview_height = 0.70,
          },
          width = 0.90,
          height = 0.99,
        },
      },
      pickers = {
        git_status = {
          previewer = false,
          theme = 'dropdown',
        },
        live_grep = grep_opts,
        grep_string = grep_opts,
        find_files = {
          hidden = true,
        },
        lsp_references = {
          show_line = false,
        },
        lsp_document_symbols = {
          symbol_width = symbol_width,
        },
        lsp_dynamic_workspace_symbols = {
          symbol_width = symbol_width,
        },
        buffers = {
          mappings = {
            i = {
              ['<C-c>'] = function(prompt_bufnr)
                require('telescope.actions').delete_buffer(prompt_bufnr)
              end,
            },
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'search help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'search keymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'search files' })
    vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = 'search builtin telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'search current word' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'search by grep' })
    vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = 'search recent files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sS', builtin.spell_suggest, { desc = 'search Spelling' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find({
        previewer = false,
      })
    end, { desc = 'fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'live Grep in Open Files',
      })
    end, { desc = 'search in Open Files' })
  end,
}
