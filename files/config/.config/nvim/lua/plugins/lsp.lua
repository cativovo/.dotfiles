return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<leader>cR", "<cmd>LspRestart<cr>" }
    keys[#keys + 1] = {
      "gSv",
      function()
        require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
      end,
      desc = "Goto Definition (vsplit)",
      has = "definition",
    }
    keys[#keys + 1] = {
      "gSx",
      function()
        require("telescope.builtin").lsp_definitions({ jump_type = "split" })
      end,
      desc = "Goto Definition (split)",
      has = "definition",
    }
  end,
  opts = {
    diagnostics = {
      float = { border = "rounded" },
    },
  },
}
