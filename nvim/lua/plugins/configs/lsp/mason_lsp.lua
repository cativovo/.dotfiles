local M = {}

local function setup()
  local present, mason_lsp = pcall(require, "mason-lspconfig");

  if not present then
    return
  end

  local options = {
    ensure_installed = { "sumneko_lua", "rust_analyzer" }
  }

  mason_lsp.setup(options)
end

M.config = function()
  setup()
end

return M
