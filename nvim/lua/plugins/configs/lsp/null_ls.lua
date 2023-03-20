local M = {}

M.setup = function()
	local null_ls = require("null-ls")

	local opts = {
		sources = {
			-- formatters
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
		},
	}

	null_ls.setup(opts)
end

return M
