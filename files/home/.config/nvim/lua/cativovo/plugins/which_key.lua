return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        local wk = require('which-key')

        local opts = {
            icons = {
                mappings = false,
            },
        }
        wk.setup(opts)

        local common_keymap = {
            { '<leader>g', group = 'git' },
            { '<leader>gh', group = 'hunk' },
            { '<leader>f', group = 'file' },
            { '<leader>fy', group = 'copy' },
        }

        local normal_keymaps = {
            { '<leader>c', group = 'code' },
            { '<leader>d', group = 'document/debugger' },
            { '<leader>s', group = 'search' },
            { '<leader>w', group = 'workspace' },
            { '<leader>t', group = 'toggle' },
            { '<leader>q', group = 'quickfixlist' },
            { '<leader>x', group = 'trouble' },
        }

        normal_keymaps = vim.list_extend(normal_keymaps, common_keymap)
        wk.add(normal_keymaps)

        -- visual mode
        local visual_keymaps = vim.list_extend({ mode = 'v' }, common_keymap)
        wk.add(visual_keymaps)
    end,
}
