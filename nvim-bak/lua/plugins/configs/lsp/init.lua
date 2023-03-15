local M = {}

local function setup()
  local lspconfig_present, lspconfig = pcall(require, "lspconfig")
  local mason_lsp_present, mason_lsp = pcall(require, "mason-lspconfig");

  if not lspconfig_present or not mason_lsp_present then
    return
  end

  local handlers = require("plugins.configs.lsp.handlers")
  local capabilities = require("plugins.configs.lsp.capabilities")


  local options = {
    on_attach = handlers.on_attach,
    capabilities = capabilities
  }

  for _, server in ipairs(mason_lsp.get_installed_servers()) do
    local path = "plugins.configs.lsp.server_options." .. server
    local server_options_present, server_options = pcall(require, path)

    if server_options_present then
      -- merge server options to common options
      options = vim.tbl_deep_extend("force", options, server_options)
    end

    lspconfig[server].setup(options)
  end

end

M.config = function()
  local diagnostics = require("plugins.configs.lsp.diagnostics")
  local null_ls = require("plugins.configs.lsp.null_ls")

  diagnostics.setup()
  null_ls.setup()
  setup()

end

return M
