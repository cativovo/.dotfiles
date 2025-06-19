return {
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, 'prettierd')
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = function(_, opts)
            local formatters_by_ft = {
                javascript = { 'prettierd' },
                javascriptreact = { 'prettierd' },
                typescript = { 'prettierd' },
                typescriptreact = { 'prettierd' },
                vue = { 'prettierd' },
                css = { 'prettierd' },
                scss = { 'prettierd' },
                less = { 'prettierd' },
                html = { 'prettierd' },
                json = { 'prettierd' },
                jsonc = { 'prettierd' },
                yaml = { 'prettierd' },
                markdown = { 'prettierd' },
                ['markdown.mdx'] = { 'prettierd' },
                graphql = { 'prettierd' },
                handlebars = { 'prettierd' },
            }

            -- killall instances of prettierd when the last instance of nvim is closed
            vim.api.nvim_create_autocmd('VimLeavePre', {
                callback = function()
                    vim.fn.jobstart('[ "$(pgrep -c nvim)" = 0 ] && killall prettierd', { detach = true })
                end,
            })

            for ft, formatters in pairs(formatters_by_ft) do
                if opts.formatters_by_ft[ft] == nil then
                    opts.formatters_by_ft[ft] = formatters
                else
                    vim.list_extend(opts.formatters_by_ft[ft], formatters)
                end
            end
        end,
    },
}
