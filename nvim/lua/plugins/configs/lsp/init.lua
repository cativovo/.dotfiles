local M = {}

local lsp_setup = function()
	local on_attach = require("plugins.configs.lsp.handler").on_attach
	local opts = {}

	for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
		local path = "plugins.configs.lsp.server_options." .. server
		local server_opts_present, server_opts = pcall(require, path)

		if server_opts_present then
			-- merge server options to common options
			opts = vim.tbl_deep_extend("force", opts, server_opts)
		end

		if server_opts.on_attach then
			opts.on_attach = function(client, buffer)
				server_opts.on_attach(client, buffer)
				on_attach(client, buffer)
			end
		else
			opts.on_attach = on_attach
		end

		require("lspconfig")[server].setup(opts)
	end
end

M.setup = function()
	require("plugins.configs.lsp.diagnostics").setup()
	lsp_setup()
end

return M
