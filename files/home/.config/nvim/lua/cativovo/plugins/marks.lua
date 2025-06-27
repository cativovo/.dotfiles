return {
    'chentoast/marks.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
    keys = {

        {
            '<leader>qm',
            '<cmd>MarksQFListBuf<cr>',
            desc = 'list marks',
        },
    },
}
