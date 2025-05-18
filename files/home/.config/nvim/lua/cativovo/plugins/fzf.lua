return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        winopts = {
            fullscreen = true,
            preview = {
                vertical = 'down:60%',
                layout = 'vertical',
            },
        },
        keymap = {
            fzf = {
                ['ctrl-q'] = 'select-all+accept',
            },
        },
    },
    keys = {
        { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'search files' },
        { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'grep current word' },
        { '<leader>sg', '<cmd>FzfLua live_grep_glob<cr>', desc = 'live grep' },
        { '<leader>sr', '<cmd>FzfLua resume<cr>', desc = 'search resume' },
        { '<leader>sS', '<cmd>FzfLua spell_suggest<cr>', desc = 'search spelling' },
        { '<leader><leader>', '<cmd>FzfLua buffers<cr>', desc = 'find existing buffers' },
        { '<leader>s.', '<cmd>FzfLua oldfiles cwd_only=true<cr>', desc = 'search recent files' },
        { '<leader>/', '<cmd>FzfLua lgrep_curbuf<cr>', desc = 'live grep in current buffer' },
    },
    config = function(_, opts)
        local fzf = require('fzf-lua')
        fzf.setup(opts)
        fzf.register_ui_select(function()
            return {
                winopts = {
                    fullscreen = false,
                },
            }
        end)
    end,
    register_lsp_keymaps = function(map)
        map('gd', '<cmd>FzfLua lsp_definitions<cr>', 'goto definition')
        map('gD', '<cmd>FzfLua lsp_typedefs<cr>', 'goto type definition')
        map('grr', '<cmd>FzfLua lsp_references<cr>', 'goto references')
        map('gO', '<cmd>FzfLua lsp_document_symbols<cr>', 'document symbols')
        map('<leader>wO', '<cmd>FzfLua lsp_live_workspace_symbols<cr>', 'workspace symbols')
        map('<leader>dd', '<cmd>FzfLua lsp_document_diagnostics<cr>', 'document diagnostics')
        map('<leader>wd', '<cmd>FzfLua lsp_workspace_diagnostics<cr>', 'workspace diagnostics')
    end,
}
