local function get_opts(name)
    local plugin = require('lazy.core.config').spec.plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require('lazy.core.plugin')
    return Plugin.values(plugin, 'opts', false)
end

local function set_keymaps(map)
    require('cativovo.plugins.fzf').register_lsp_keymaps(map)
    map('<leader>dl', vim.diagnostic.open_float, 'line diagnostics')
    map('<leader>qd', vim.diagnostic.setqflist, 'open diagnostic quickfix list')

    local diagnostic_goto = function(next, severity)
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
            local count = 1
            if not next then
                count = -1
            end
            vim.diagnostic.jump({ severity = severity, count = count })
        end
    end

    map(']d', diagnostic_goto(true), 'next diagnostic')
    map('[d', diagnostic_goto(false), 'prev diagnostic')
    map(']e', diagnostic_goto(true, 'ERROR'), 'next error')
    map('[e', diagnostic_goto(false, 'ERROR'), 'prev error')
    map(']w', diagnostic_goto(true, 'WARN'), 'next warning')
    map('[w', diagnostic_goto(false, 'WARN'), 'prev warning')

    -- Restart lsp
    map('<leader>cR', '<cmd>LspRestart<cr>', 'restart LSP')
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        { 'mason-org/mason.nvim', config = true, version = '^1.0.0' },
        { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function(_, opts)
        local servers = opts.servers or {}

        require('cativovo.utils').on_lsp_attach(function(client, bufnr)
            -- In this case, we create a function that lets us more easily define mappings specific
            -- for LSP related items. It sets the mode, buffer and description for us each time.
            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
            end

            set_keymaps(map)

            if client ~= nil then
                local server = servers[client.name]
                if server ~= nil then
                    local keys = servers[client.name].keys

                    if keys ~= nil then
                        for _, value in ipairs(keys) do
                            map(value[1], value[2], value.desc)
                        end
                    end
                end
            end

            if client and client.server_capabilities.documentHighlightProvider then
                local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = bufnr,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = bufnr,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd('LspDetach', {
                    group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                    callback = function(event)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event.buf })
                    end,
                })
            end

            -- The following autocommand is used to enable inlay hints in your
            -- code, if the language server you are using supports them
            --
            -- This may be unwanted, since they displace some of your code
            if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                map('<leader>th', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, 'toggle inlay hints')
            end
        end, 'init')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local setups = opts.setups or {}
        local ensure_installed = vim.tbl_keys(servers or {})
        local ensure_installed_from_opts = get_opts('mason-tool-installer.nvim').ensure_installed or {}
        vim.list_extend(ensure_installed, ensure_installed_from_opts)

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

        -- diagnostics
        local icons = require('cativovo.config.icons')
        local diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = {
                source = 'if_many',
                prefix = '',
            },
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                    [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                    [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                },
            },
            float = { border = 'rounded' },
        }

        vim.diagnostic.config(diagnostics)

        require('mason-lspconfig').setup({
            automatic_enable = true,
            ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
            handlers = {
                function(server_name)
                    local server_opts = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})

                    if setups[server_name] ~= nil then
                        -- may update server_opts
                        local skip_setup = setups[server_name](server_opts)
                        if skip_setup == true then
                            return
                        end
                    end

                    require('lspconfig')[server_name].setup(server_opts)
                end,
            },
        })
    end,
}
