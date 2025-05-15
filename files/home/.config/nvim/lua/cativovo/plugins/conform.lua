local autoformat = true

return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
        {
            '<leader>tf',
            function()
                autoformat = not autoformat
                local status = 'off'
                if autoformat then
                    status = 'on'
                end
                vim.notify('autoformat: ' .. status)
            end,
            desc = 'toggle autoformat',
        },
        {
            '<leader>fb',
            function()
                require('conform').format({ async = true, lsp_fallback = true })
            end,
            mode = '',
            desc = 'format buffer',
        },
    },
    opts = {
        notify_on_error = true,
        format_on_save = function()
            if not autoformat then
                return
            end

            return {
                timeout_ms = 3000,
            }
        end,
    },
}
