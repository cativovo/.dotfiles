return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']h', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, { desc = 'jump to next git change' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[h', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = 'jump to previous git change' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = 'git stage buffer' })
        map('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = 'git undo stage hunk' })
        map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = 'git reset buffer' })
        map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'git preview hunk' })
        map('n', '<leader>ghb', gitsigns.blame_line, { desc = 'git blame line' })
        map('n', '<leader>ghd', gitsigns.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>ghD', function()
          gitsigns.diffthis('@')
        end, { desc = 'git diff against last commit' })
        map('n', '<leader>ghq', gitsigns.setqflist, { desc = 'list hunks in quickfix' })
      end,
    },
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'Git' },
    keys = {
      { '<leader>gf', '<cmd>Git<cr>', desc = 'fugitive' },
    },
  },
}
