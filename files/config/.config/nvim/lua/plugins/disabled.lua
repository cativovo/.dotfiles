local M = {}

local disabled_plugins = {
  -- ui
  "glepnir/dashboard-nvim",
  "akinsho/bufferline.nvim",
  "rcarriga/nvim-notify",
  -- editor
  "nvim-pack/nvim-spectre",
  "echasnovski/mini.bufremove",
  "folke/trouble.nvim",
  -- lsp
  "folke/neoconf.nvim",
  -- util
  "folke/persistence.nvim",
  -- colorscheme
  "folke/tokyonight.nvim",
  -- coding
  "echasnovski/mini.pairs",
  "nvim-treesitter/nvim-treesitter-context",
}

for _, value in pairs(disabled_plugins) do
  table.insert(M, { value, enabled = false })
end

return M