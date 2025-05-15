return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'markdown', 'markdown_inline' })
        end,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'markdownlint' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                marksman = {},
            },
        },
    },
    -- Markdown preview
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        keys = {
            {
                '<leader>cp',
                ft = 'markdown',
                '<cmd>MarkdownPreviewToggle<cr>',
                desc = 'Markdown Preview',
            },
        },
        config = function()
            vim.g.mkdp_auto_close = 0
            vim.cmd([[do FileType]])
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        opts = function(_, opts)
            local null_ls = require('null-ls')
            opts.sources = opts.sources or {}
            opts.sources = vim.list_extend(opts.sources, {
                null_ls.builtins.diagnostics.markdownlint,
            })
        end,
    },
}
