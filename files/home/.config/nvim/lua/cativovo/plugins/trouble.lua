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
            '<leader>xX',
            '<cmd>Trouble diagnostics toggle focus=true<cr>',
            desc = 'workspace diagnostics',
        },
        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>',
            desc = 'document diagnostics',
        },
        {
            '<leader>xs',
            '<cmd>Trouble symbols toggle focus=true<cr>',
            desc = 'symbols',
        },
        {
            '<leader>xl',
            '<cmd>Trouble lsp toggle focus=false win.position=right focus=true<cr>',
            desc = 'LSP definitions / references / ...',
        },
        {
            '<leader>xL',
            '<cmd>Trouble loclist toggle<cr>',
            desc = 'location list',
        },
        {
            '<leader>xQ',
            '<cmd>Trouble qflist toggle<cr>',
            desc = 'quickfix list',
        },
    },
}
