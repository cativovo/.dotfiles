local M = {}

local lsp_setup = function()
	local on_attach = require("plugins.configs.lsp.handler").on_attach
	local opts = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = on_attach,
	}

	for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
		local path = "plugins.configs.lsp.server_options." .. server
		local server_opts_present, server_opts = pcall(require, path)

		if server_opts_present then
			-- merge server options to common options
			opts = vim.tbl_deep_extend("force", opts, server_opts)
		end

		require("lspconfig")[server].setup(opts)
	end
end

M.setup = function()
	require("plugins.configs.lsp.diagnostics").setup()
	lsp_setup()
end

return M
