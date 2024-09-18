local M = {}

M.extend = function(t, key, values)
  local keys = vim.split(key, '.', { plain = true })
  for i = 1, #keys do
    local k = keys[i]
    t[k] = t[k] or {}
    if type(t) ~= 'table' then
      return
    end
    t = t[k]
  end
  return vim.list_extend(t, values)
end

local lsp = require('cativovo.utils.lsp')
M.get_pkg_path = lsp.get_pkg_path
M.on_lsp_attach = lsp.on_lsp_attach

local path = require('cativovo.utils.path')
M.root_has_file = path.root_has_file

local ui = require('cativovo.utils.ui')
M.maximize = ui.maximize
M.statuscolumn = ui.statuscolumn

return M
