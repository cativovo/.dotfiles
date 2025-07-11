return {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            version = '2.*',
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
            },
            opts = {},
        },
        'folke/lazydev.nvim',
    },
    opts = {
        keymap = {
            preset = 'default',
            ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-u>'] = { 'scroll_documentation_down', 'fallback' },
            ['<Right>'] = { 'snippet_forward', 'fallback' },
            ['<Left>'] = { 'snippet_backward', 'fallback' },

            -- disable
            ['<C-b>'] = false,
            ['<C-f>'] = false,
            ['<Tab>'] = false,
            ['<S-Tab>'] = false,
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            accept = { auto_brackets = { enabled = false } },
            documentation = { auto_show = true, auto_show_delay_ms = 100 },
            ghost_text = { enabled = true, show_with_menu = true },
        },
        sources = {
            default = { 'lsp', 'snippets', 'path', 'lazydev' },
            providers = {
                lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
            },
        },
        snippets = { preset = 'luasnip' },
        fuzzy = { implementation = 'lua' },
        signature = { enabled = true },
    },
}
