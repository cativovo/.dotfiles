local M = {}

-- run eslint_d if there's a eslint file config
local eslint_condition = function(utils)
	return utils.root_has_file({
		".eslintrc.cjs",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		".eslintrc",
	})
end

M.setup = function()
	local null_ls = require("null-ls")

	local opts = {
		sources = {
			-- diagnostics
			null_ls.builtins.diagnostics.eslint_d.with({
				condition = eslint_condition,
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/226
				timeout = 1000000,
			}),
			-- code actions
			null_ls.builtins.code_actions.eslint_d.with({
				condition = eslint_condition,
			}),
			-- formatters
			null_ls.builtins.formatting.stylua,
			-- if prettierd is not working - https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1119
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.eslint_d.with({
				condition = eslint_condition,
			}),
		},
	}

	null_ls.setup(opts)
end

return M
