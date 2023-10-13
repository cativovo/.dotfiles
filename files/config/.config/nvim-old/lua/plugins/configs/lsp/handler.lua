local M = {}

local register_keys = function(buffer)
	require("which-key").register(require("core.keymaps").lsp.normal, { buffer })
end

M.common_on_attach = function(client, buffer)
	-- disable custom sytax highlighting of each server
	-- client.server_capabilities.semanticTokensProvider = nil

	register_keys(buffer)

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, buffer)
	end
end

return M
