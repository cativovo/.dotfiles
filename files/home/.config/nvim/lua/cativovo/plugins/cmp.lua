return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            'L3MON4D3/LuaSnip',
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
        },
        'saadparwaiz1/cmp_luasnip',

        -- Adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. They are split
        --  into multiple repos for maintenance purposes.
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
    },
    config = function(_, opts)
        -- See `:help cmp`
        local cmp = require('cmp')
        local defaults = require('cmp.config.default')()

        local bordered = cmp.config.window.bordered
        local luasnip = require('luasnip')
        luasnip.config.setup({})

        local hl_group = 'CmpGhostText'

        vim.api.nvim_set_hl(0, hl_group, { link = 'Comment', default = true })

        cmp.setup({
            -- enabled = false,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },

            -- Please read `:help ins-completion`, it is really good!
            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ['<C-n>'] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ['<C-p>'] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),

                -- If you prefer more traditional completion keymaps,
                -- you can uncomment the following lines
                --['<CR>'] = cmp.mapping.confirm { select = true },
                --['<Tab>'] = cmp.mapping.select_next_item(),
                --['<S-Tab>'] = cmp.mapping.select_prev_item(),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ['<C-Space>'] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            },
            window = {
                completion = bordered(),
                documentation = bordered(),
            },
            formatting = {
                fields = defaults.formatting.fields,
                expandable_indicator = defaults.formatting.expandable_indicator,
                format = function(entry, item)
                    local icons = require('cativovo.config.icons').kinds
                    if icons[item.kind] then
                        item.kind = icons[item.kind] .. item.kind
                    end

                    local max_text_length = 50

                    if #item.abbr > max_text_length then
                        item.abbr = string.sub(item.abbr, 1, max_text_length - 1) .. '…'
                    end

                    if item.menu ~= nil then
                        item.menu = nil
                    end

                    if opts and opts.formatting and opts.formatting.format then
                        -- apply custom format from other config e.g. lang/tailwind.lua
                        return opts.formatting.format(entry, item)
                    end

                    return item
                end,
            },
            experimental = {
                ghost_text = {
                    hl_group = hl_group,
                },
            },
            sorting = defaults.sorting,
        })
    end,
}
