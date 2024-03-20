return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<leader>cR", "<cmd>LspRestart<cr>" }
  end,
  opts = {
    diagnostics = {
      float = { border = "rounded" },
    },
  },
}
