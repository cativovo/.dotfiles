local function get_opts(name)
  local plugin = require('lazy.core.config').spec.plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require('lazy.core.plugin')
  return Plugin.values(plugin, 'opts', false)
end

local function set_keymaps(map)
  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('gd', require('telescope.builtin').lsp_definitions, 'goto definition')

  -- Find references for the word under your cursor.
  map('gr', require('telescope.builtin').lsp_references, 'goto references')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('gI', require('telescope.builtin').lsp_implementations, 'goto implementation')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'type definition')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'document symbols')

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace symbols')

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map('<leader>cr', vim.lsp.buf.rename, 'rename')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('<leader>ca', vim.lsp.buf.code_action, 'code action')

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap.
  map('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map('gD', vim.lsp.buf.declaration, 'goto declaration')

  -- Diagnostics
  map('<leader>dd', function()
    require('telescope.builtin').diagnostics({ bufnr = 0 })
  end, 'document diagnostics')
  map('<leader>wd', require('telescope.builtin').diagnostics, 'workspace diagnostics')
  map('<leader>dl', vim.diagnostic.open_float, 'line diagnostics')
  map('<leader>qd', vim.diagnostic.setqflist, 'open diagnostic quickfix list')

  local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
      go({ severity = severity })
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
  event = 'VeryLazy',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'williamboman/mason.nvim',
      config = true,
    },
  },
  config = function(_, opts)
    local servers = opts.servers or {}

    require('cativovo.utils').on_lsp_attach(function(client, buffer)
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
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
          buffer = buffer,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = buffer,
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

    -- add border to hover text
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

    -- diagnostics
    local icons = require('cativovo.config.icons')
    local diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
      signs = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
      },
      float = { border = 'rounded' },
    }

    for severity, icon in pairs(diagnostics.signs) do
      local name = vim.diagnostic.severity[severity]:lower():gsub('^%l', string.upper)
      name = 'DiagnosticSign' .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
    end

    diagnostics.virtual_text.prefix = vim.fn.has('nvim-0.10.0') == 0 and '●'
      or function(diagnostic)
        for d, icon in pairs(icons.diagnostics) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end

    vim.diagnostic.config(diagnostics)

    require('mason-lspconfig').setup({
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
