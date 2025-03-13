return {
    'folke/trouble.nvim',
    opts = {
        modes = {
            symbols = {
                focus = true,
                win = { position = 'bottom', size = 0.3 },
            },
        },
    },
    cmd = 'Trouble',
    keys = {
        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle<cr>',
            desc = 'Diagnostics',
        },
        {
            '<leader>xX',
            '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
            desc = 'Buffer Diagnostics',
        },
        {
            '<leader>xs',
            '<cmd>Trouble symbols toggle<cr>',
            desc = 'Symbols',
        },
        {
            '<leader>xl',
            '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
            desc = 'LSP Definitions / references / ...',
        },
        {
            '<leader>xL',
            '<cmd>Trouble loclist toggle<cr>',
            desc = 'Location List',
        },
        {
            '<leader>xQ',
            '<cmd>Trouble qflist toggle<cr>',
            desc = 'Quickfix List',
        },
    },
}
