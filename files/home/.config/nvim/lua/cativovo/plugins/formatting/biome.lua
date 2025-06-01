return {
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, 'biome')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                biome = {},
            },
        },
    },
    {
        'stevearc/conform.nvim',
        opts = function(_, opts)
            local formatters_by_ft = {
                javascript = { 'biome' },
                javascriptreact = { 'biome' },
                typescript = { 'biome' },
                typescriptreact = { 'biome' },
                vue = { 'biome' },
                css = { 'biome' },
                scss = { 'biome' },
                less = { 'biome' },
                html = { 'biome' },
                json = { 'biome' },
                jsonc = { 'biome' },
                yaml = { 'biome' },
                markdown = { 'biome' },
                ['markdown.mdx'] = { 'biome' },
                graphql = { 'biome' },
                handlebars = { 'biome' },
            }

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
