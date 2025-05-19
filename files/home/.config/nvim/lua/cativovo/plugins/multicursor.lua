return {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
        local mc = require('multicursor-nvim')

        -- https://github.com/jake-stewart/multicursor.nvim/blob/cb8ee9dde77da5bf5ef7d3d2a3898fe2082834e8/lua/multicursor-nvim/cursor-manager.lua#L1765
        mc.setup({ signs = nil })

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({ 'n', 'v' }, '<up>', function()
            mc.lineAddCursor(-1)
        end)
        set({ 'n', 'v' }, '<down>', function()
            mc.lineAddCursor(1)
        end)
        set({ 'n', 'v' }, '<C-up>', function()
            mc.lineSkipCursor(-1)
        end)
        set({ 'n', 'v' }, '<C-down>', function()
            mc.lineSkipCursor(1)
        end)

        -- Add or skip adding a new cursor by matching word/selection
        set({ 'n', 'v' }, '<C-n>', function()
            mc.matchAddCursor(1)
        end)
        set({ 'n', 'v' }, '<C-s>', function()
            mc.matchSkipCursor(1)
        end)
        set({ 'n', 'v' }, '<A-n>', function()
            mc.matchAddCursor(-1)
        end)
        set({ 'n', 'v' }, '<A-s>', function()
            mc.matchSkipCursor(-1)
        end)

        -- Rotate the main cursor.
        set({ 'n', 'v' }, '<A-up>', mc.prevCursor)
        set({ 'n', 'v' }, '<A-down>', mc.nextCursor)

        -- Add and remove cursors with control + left click.
        set('n', '<c-leftmouse>', mc.handleMouse)

        set('n', '<esc>', function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                -- clear highlight from hlsearch
                vim.cmd('nohlsearch')
            end
        end)

        -- Split visual selections by regex.
        set('v', 'S', mc.splitCursors)

        -- Append/insert for each line of visual selections.
        set('v', 'I', mc.insertVisual)
        set('v', 'A', mc.appendVisual)
        set('v', '<C-v>', mc.visualToCursors)

        -- match new cursors within visual selections by regex.
        set('v', 'M', mc.matchCursors)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, 'MultiCursorCursor', { link = 'Cursor' })
        hl(0, 'MultiCursorVisual', { link = 'Visual' })
        hl(0, 'MultiCursorSign', { link = 'SignColumn' })
        hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
        hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
        hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
}
