return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'VeryLazy' },
        opts = {
            -- Autoinstall languages that are not installed
            auto_install = true,
            ensure_installed = { 'bash', 'diff', 'html', 'markdown', 'vim', 'vimdoc' },
            highlight = {
                enable = true,
            },
            indent = { enable = true },
        },
        config = function(_, opts)
            -- Prefer git instead of curl in order to improve connectivity in some environments
            require('nvim-treesitter.install').prefer_git = true
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function(_, opts)
            vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { bg = '#313244' })
            vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { bg = '#313244' })
            require('treesitter-context').setup(opts)
        end,
        opts = {
            max_lines = 6,
        },
    },
}
