local M = {}
local load_keymaps = require("plugins.configs.lsp.keymaps").load

M.on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  load_keymaps(bufnr)

  if client.server_capabilities.signatureHelpProvider then
    -- require("nvchad_ui.signature").setup(client)
  end
end

return M
