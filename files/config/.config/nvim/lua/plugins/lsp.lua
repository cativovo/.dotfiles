return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- DISABLED
    keys[#keys + 1] = { "]d", false }
    keys[#keys + 1] = { "[d", false }
    keys[#keys + 1] = { "]e", false }
    keys[#keys + 1] = { "[e", false }
    keys[#keys + 1] = { "]w", false }
    keys[#keys + 1] = { "[w", false }
    -- MY KEYS
    keys[#keys + 1] = { "<A-l>", vim.diagnostic.goto_next, "Next Diagnostic" }
    keys[#keys + 1] = { "<A-h>", vim.diagnostic.goto_prev, "Prev Diagnostic" }
  end,
  opts = {
    diagnostics = {
      float = { border = "rounded" },
    },
  },
}
