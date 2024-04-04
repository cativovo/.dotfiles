local M = {}

local disabled_plugins = {
  -- ui
  "nvimdev/dashboard-nvim",
  "akinsho/bufferline.nvim",
  "rcarriga/nvim-notify",
  -- editor
  "nvim-pack/nvim-spectre",
  "echasnovski/mini.bufremove",
  -- lsp
  "folke/neoconf.nvim",
  -- util
  "folke/persistence.nvim",
  -- colorscheme
  "folke/tokyonight.nvim",
  -- coding
  "echasnovski/mini.pairs",
  "echasnovski/mini.ai",
  -- lang
  "lukas-reineke/headlines.nvim",
}

for _, value in pairs(disabled_plugins) do
  table.insert(M, { value, enabled = false })
end

return M
