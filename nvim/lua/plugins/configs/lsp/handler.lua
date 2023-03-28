local M = {}

local register_keys = function(buffer)
	require("which-key").register(require("core.keymaps").lsp.normal(require("telescope.builtin")), { buffer })
end

M.on_attach = function(_, buffer)
	register_keys(buffer)
	local autocmds = require("core.autocmds")
	autocmds.autoformat(buffer)
end

return M
