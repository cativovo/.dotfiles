local M = {}
local load_mappings = require("core.utils").load_mappings

M.on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    -- require("nvchad_ui.signature").setup(client)
  end
end

return M
