local M = {}

local register_keys = function(buffer)
  require("which-key").register(require("core.keymaps").lsp.get("normal", require("telescope.builtin")), { buffer })
end

M.on_attach = function(_, buffer)
  register_keys(buffer)
  require("core.autocmds").autoformat(buffer)
end


return M
