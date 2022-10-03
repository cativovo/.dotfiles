local M = {}
local load_keymaps = require("plugins.configs.lsp.keymaps").load
local utils = require("core.utils")

M.on_attach = function(_, bufnr)
  utils.enable_format_on_save(bufnr)
  load_keymaps(bufnr)
end


return M
