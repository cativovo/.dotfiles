return {
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, 'eslint')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                eslint = {
                    settings = {
                        -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
                        workingDirectories = { mode = 'auto' },
                    },
                    keys = {
                        {
                            '<leader>cf',
                            '<cmd>EslintFixAll<cr>',
                            desc = 'EslintFixAll',
                        },
                    },
                },
            },
        },
    },
}
