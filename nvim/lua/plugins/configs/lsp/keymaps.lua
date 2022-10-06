local M = {}

M.load = function(buffer)
  local keymaps = {
    n = {
      ["<leader>la"] = { vim.lsp.buf.code_action, "Code Action" },
      -- for non mac os
      -- ["<A-p>"] = {
      --   function()
      --     vim.lsp.buf.format({
      --       filter = function(client)
      --         -- block format on save if server is tsserver to use null-ls instead
      --         return client.name ~= "tsserver"
      --       end,
      --     })
      --   end,
      --   "Format"
      -- },
      ["π"] = {
        function()
          vim.lsp.buf.format({
            filter = function(client)
              -- block format on save if server is tsserver to use null-ls instead
              return client.name ~= "tsserver"
            end,
          })
        end,
        "Format"
      },
      ["<leader>li"] = { ":LspInfo<CR>", "Info" },
      ["<leader>lI"] = { ":Mason<CR>", "Mason Info" },
      ["<leader>lr"] = { vim.lsp.buf.rename, "Rename" },
      ["<leader>lq"] = { vim.diagnostic.setloclist, "Quickfix" },
      ["K"] = { vim.lsp.buf.hover, "Show hover" },

      -- diagnostics
      -- non macbook mappings
      -- ["<A-l>"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      -- ["<A-h>"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      -- macbook mappings
      ["¬"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      ["˙"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      ["<leader>ll"] = {
        function()
          vim.diagnostic.open_float(0, { scope = 'line' })
        end,
        "Show Current Line Diagnostic"
      },
    }
  }

  require("core.utils").load_keymaps(keymaps, { buffer = buffer, silent = true })
end

return M
