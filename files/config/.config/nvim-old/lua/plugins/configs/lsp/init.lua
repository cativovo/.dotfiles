local M = {}

local lsp_setup = function()
	local common_on_attach = require("plugins.configs.lsp.handler").common_on_attach
	local opts = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = common_on_attach,
	}

	for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
		local path = "plugins.configs.lsp.server_options." .. server
		local server_opts_present, server_opts = pcall(require, path)

		if server_opts_present then
			-- merge server options to common options
			opts = vim.tbl_deep_extend("force", opts, server_opts)
		end

		if server_opts.on_attach then
			opts.on_attach = function(client, buffer)
				common_on_attach(client, buffer)

				if client.name == server then
					server_opts.on_attach(client, buffer)
				end
			end
		end

		require("lspconfig")[server].setup(opts)
	end
end

M.setup = function()
	require("plugins.configs.lsp.diagnostics").setup()
	lsp_setup()
	require("core.autocmds").autoformat()
end

return M
