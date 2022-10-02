local M = {}

M.load = function(buffer)
  local present, telescope_builtin = pcall(require, "telescope.builtin")

  if not present then
    return
  end

  local keymaps = {
    n = {
      -- go to
      ["<leader>lgd"] = { telescope_builtin.lsp_definitions, "Definition" },
      ["<leader>lgt"] = { telescope_builtin.lsp_type_definitions, "Type Definition" },
      ["<leader>lgi"] = { telescope_builtin.lsp_implementations, "Implementation" },
      ["<leader>lgr"] = { telescope_builtin.lsp_references, "Reference" },

      ["<leader>la"] = { vim.lsp.buf.code_action, "Code Action" },
      ["<leader>ld"] = {
        function()
          telescope_builtin.diagnostics({ bufnr = 0, theme = "get_ivy" })
        end,
        "Buffer Diagnostics"
      },
      -- for non mac os
      -- ["<A-p>"] = { ":lua vim.lsp.buf.formatting_sync(nil, 5000)<CR>", "Format" },
      ["π"] = {
        function()
          local max_timeout = 5000
          vim.lsp.buf.formatting_sync(nil, max_timeout)
        end, "Format"
      },
      ["<leader>li"] = { ":LspInfo<CR>", "Info" },
      ["<leader>lI"] = { ":Mason<CR>", "Mason Info" },
      ["<leader>ls"] = { telescope_builtin.lsp_document_symbols, "Document Symbols" },
      ["<leader>lS"] = { telescope_builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols" },
      ["<leader>le"] = { telescope_builtin.quickfix, "Telescope Quickfix" },
      ["<leader>lr"] = { vim.lsp.buf.rename, "Rename" },
      ["<leader>lq"] = { vim.diagnostic.setloclist, "Quickfix" },
      ["K"] = { vim.lsp.buf.hover, "Show hover" },

      -- diagnostics
      -- non macbook mappings
      -- ["<A-j>"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      -- ["<A-k>"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      -- macbook mappings
      ["∆"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      ["˚"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      ["<leader>ll"] = {
        function()
          vim.diagnostic.open_float(0, { scope = 'line' })
        end,
        "Show Current Line Diagnostic"
      },
      ["<leader>lw"] = { telescope_builtin.diagnostics, "Diagnostics" },
    }
  }

  require("core.utils").load_keymaps(keymaps, { buffer = buffer, silent = true })
end

return M
