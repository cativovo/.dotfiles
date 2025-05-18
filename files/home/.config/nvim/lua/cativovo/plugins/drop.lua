return {
    {
        'Bekaboo/dropbar.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<leader>;', dropbar_api.pick, { desc = 'pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'select next context' })

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
