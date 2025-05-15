return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                vim.list_extend(opts.ensure_installed, { 'typescript', 'tsx' })
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            -- make sure mason installs the server
            servers = {
                vtsls = {
                    -- explicitly add default filetypes, so that we can extend
                    -- them in related extras
                    filetypes = {
                        'javascript',
                        'javascriptreact',
                        'javascript.jsx',
                        'typescript',
                        'typescriptreact',
                        'typescript.tsx',
                        'vue',
                    },
                    settings = {
                        complete_function_calls = true,
                        vtsls = {
                            enableMoveToFileCodeAction = true,
                            autoUseWorkspaceTsdk = true,
                            experimental = {
                                completion = {
                                    enableServerSideFuzzyMatch = true,
                                },
                            },
                        },
                        typescript = {
                            updateImportsOnFileMove = { enabled = 'always' },
                            suggest = {
                                completeFunctionCalls = true,
                            },
                            inlayHints = {
                                enumMemberValues = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                                parameterNames = { enabled = 'literals' },
                                parameterTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                variableTypes = { enabled = false },
                            },
                        },
                    },
                    keys = {
                        {
                            'gD',
                            function()
                                require('vtsls').commands.goto_source_definition(0)
                            end,
                            desc = 'Goto Source Definition',
                        },
                        {
                            'gR',
                            function()
                                require('vtsls').commands.file_references(0)
                            end,
                            desc = 'File References',
                        },
                        {
                            '<leader>co',
                            function()
                                require('vtsls').commands.organize_imports(0)
                            end,
                            desc = 'Organize Imports',
                        },
                        {
                            '<leader>cM',
                            function()
                                require('vtsls').commands.add_missing_imports(0)
                            end,
                            desc = 'Add missing imports',
                        },
                        {
                            '<leader>cu',
                            function()
                                require('vtsls').commands.remove_unused_imports(0)
                            end,
                            desc = 'Remove unused imports',
                        },
                        {
                            '<leader>cD',
                            function()
                                require('vtsls').commands.fix_all(0)
                            end,
                            desc = 'Fix all diagnostics',
                        },
                        {
                            '<leader>cV',
                            function()
                                require('vtsls').commands.select_ts_version(0)
                            end,
                            desc = 'Select TS workspace version',
                        },
                    },
                },
            },
            setups = {
                vtsls = function(opts)
                    require('cativovo.utils').on_lsp_attach(function(client, buffer)
                        client.commands['_typescript.moveToFileRefactoring'] = function(command, ctx)
                            ---@type string, string, lsp.Range
                            local action, uri, range = unpack(command.arguments)

                            local function move(newf)
                                client.request('workspace/executeCommand', {
                                    command = command.command,
                                    arguments = { action, uri, range, newf },
                                })
                            end

                            local fname = vim.uri_to_fname(uri)
                            client.request('workspace/executeCommand', {
                                command = 'typescript.tsserverRequest',
                                arguments = {
                                    'getMoveToRefactoringFileSuggestions',
                                    {
                                        file = fname,
                                        startLine = range.start.line + 1,
                                        startOffset = range.start.character + 1,
                                        endLine = range['end'].line + 1,
                                        endOffset = range['end'].character + 1,
                                    },
                                },
                            }, function(_, result)
                                ---@type string[]
                                local files = result.body.files
                                table.insert(files, 1, 'Enter new path...')
                                vim.ui.select(files, {
                                    prompt = 'Select move destination:',
                                    format_item = function(f)
                                        return vim.fn.fnamemodify(f, ':~:.')
                                    end,
                                }, function(f)
                                    if f and f:find('^Enter new path') then
                                        vim.ui.input({
                                            prompt = 'Enter move destination:',
                                            default = vim.fn.fnamemodify(fname, ':h') .. '/',
                                            completion = 'file',
                                        }, function(newf)
                                            return newf and move(newf)
                                        end)
                                    elseif f then
                                        move(f)
                                    end
                                end)
                            end)
                        end
                    end, 'vtsls')
                    -- copy typescript settings to javascript
                    opts.settings.javascript = vim.tbl_deep_extend('force', {}, opts.settings.typescript, opts.settings.javascript or {})
                end,
            },
        },
    },
    {
        'yioneko/nvim-vtsls',
        lazy = true,
        opts = {},
        config = function(_, opts)
            require('vtsls').config(opts)
        end,
    },
}
