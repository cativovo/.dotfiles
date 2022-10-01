local M = vim.lsp.protocol.make_client_capabilities()

local present, cmp_lsp = pcall(require, 'cmp_nvim_lsp')

if present then
  M = cmp_lsp.update_capabilities(M)
end

M.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

return M
