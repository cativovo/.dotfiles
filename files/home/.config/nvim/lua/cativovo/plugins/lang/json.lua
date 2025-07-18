return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'json', 'json5', 'jsonc' })
        end,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'jsonlint' })
        end,
    },
    {
        'b0o/SchemaStore.nvim',
        lazy = true,
        version = false, -- last release is way too old
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                jsonls = {
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                        vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
                    end,
                    settings = {
                        json = {
                            format = {
                                enable = true,
                            },
                            validate = { enable = true },
                        },
                    },
                },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        opts = {
            linters_by_ft = {
                json = { 'jsonlint' },
            },
        },
    },
}
