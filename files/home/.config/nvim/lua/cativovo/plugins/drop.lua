return {
    {
        'Bekaboo/dropbar.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable('make') == 1
            end,
        },
        config = function()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

            local dropdown_utils = require('dropbar.utils')
            local dropbar_opts = require('dropbar.configs')

            dropbar_opts.opts.menu.keymaps['o'] = function()
                local menu = dropdown_utils.menu.get_current()
                if not menu then
                    return
                end
                local cursor = vim.api.nvim_win_get_cursor(menu.win)
                local entry = menu.entries[cursor[1]]
                local component = entry:first_clickable(entry.padding.left + entry.components[1]:bytewidth())
                if component then
                    menu:click_on(component, nil, 1, 'l')
                end
            end
        end,
    },
}
