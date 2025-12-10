return {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.o.statusline = ' '
        else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    opts = {
        options = {
            disabled_filetypes = { statusline = { 'lazy' } },
            globalstatus = true,
        },
        sections = {
            lualine_a = { 'branch' },
            lualine_b = { 'diagnostics' },
            lualine_c = {
                {
                    'filename',
                    path = 1,
                },
                require('cativovo.plugins.grapple').lualine_component,
            },
            lualine_x = {
                'filetype',
                'lsp_status',
            },
            lualine_y = {
                {
                    -- https://github.com/nvim-lualine/lualine.nvim/blob/15884cee63a8c205334ab13ab1c891cd4d27101a/lua/lualine/components/location.lua#L1
                    function()
                        local line = vim.fn.line('.')
                        local col = vim.fn.charcol('.')
                        local total = vim.fn.line('$')
                        return string.format('%d/%d:%d', line, total, col)
                    end,
                },
            },
            lualine_z = {},
        },
        extensions = {
            'lazy',
            'quickfix',
        },
    },
}
