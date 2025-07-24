function lualine_component()
    local keymap = {
        ['1'] = 'j',
        ['2'] = 'k',
        ['3'] = 'l',
        ['4'] = ';',
        ['5'] = 'u',
        ['6'] = 'i',
        ['7'] = 'o',
        ['8'] = 'p',
    }

    local grapple = require('grapple')
    local app = grapple.app()
    local tags, err = grapple.tags()
    if not tags then
        return err
    end

    local current = grapple.find({ buffer = 0 })

    local quick_select = app.settings:quick_select()
    local output = {}

    for i, tag in ipairs(tags) do
        local tag_str = tag.name and tag.name or quick_select[i] and quick_select[i] or i
        local tag_fmt = ' %s '
        if current and current.path == tag.path then
            tag_fmt = '[%s]'
        end

        table.insert(output, string.format(tag_fmt, keymap[tag_str]))
    end

    local statusline = table.concat(output)
    statusline = string.format('%s %s', '󰛢', statusline)

    return statusline
end

return {
    'cbochs/grapple.nvim',
    cmd = 'Grapple',
    config = true,
    keys = {
        { '<leader>fa', '<cmd>Grapple tag<cr>', desc = 'tag a file' },
        { '<leader>fm', '<cmd>Grapple toggle_tags<cr>', desc = 'toggle tags menu' },
        { '<leader>fj', '<cmd>Grapple select index=1<cr>', desc = 'select first tag' },
        { '<leader>fk', '<cmd>Grapple select index=2<cr>', desc = 'select second tag' },
        { '<leader>fl', '<cmd>Grapple select index=3<cr>', desc = 'select third tag' },
        { '<leader>f;', '<cmd>Grapple select index=4<cr>', desc = 'select fourth tag' },
        { '<leader>fu', '<cmd>Grapple select index=5<cr>', desc = 'select fifth tag' },
        { '<leader>fi', '<cmd>Grapple select index=6<cr>', desc = 'select sixth tag' },
        { '<leader>fo', '<cmd>Grapple select index=7<cr>', desc = 'select seventh tag' },
        { '<leader>fp', '<cmd>Grapple select index=8<cr>', desc = 'select eighth tag' },
    },
    lualine_component = lualine_component,
}
