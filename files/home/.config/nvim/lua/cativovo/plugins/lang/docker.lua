return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'dockerfile' })
        end,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'hadolint' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                dockerls = {},
                docker_compose_language_service = {},
            },
        },
    },
    {
        'nvimtools/none-ls.nvim',
        opts = function(_, opts)
            local null_ls = require('null-ls')
            opts.sources = opts.sources or {}
            opts.sources = vim.list_extend(opts.sources, {
                null_ls.builtins.diagnostics.hadolint,
            })
        end,
    },
}
