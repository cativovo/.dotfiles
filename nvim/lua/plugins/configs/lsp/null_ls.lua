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
			}),
			-- code actions
			null_ls.builtins.code_actions.eslint_d.with({
				condition = eslint_condition,
			}),
			-- formatters
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.formatting.eslint_d.with({
				condition = eslint_condition,
			}),
		},
	}

	null_ls.setup(opts)
end

return M
