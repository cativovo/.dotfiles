local M = {}

local register_keys = function(buffer)
	require("which-key").register(require("core.keymaps").lsp.normal, { buffer })
end

M.common_on_attach = function(client, buffer)
	-- disable custom sytax highlighting of each server
	client.server_capabilities.semanticTokensProvider = nil

	register_keys(buffer)
	local autocmds = require("core.autocmds")
	autocmds.autoformat(buffer)
end

return M
