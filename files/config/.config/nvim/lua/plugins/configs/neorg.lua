local M = {}

M.base_directory = "~/notes"

M.setup = function()
	local opts = {
		load = {
			["core.defaults"] = {}, -- Loads default behaviour
			["core.concealer"] = { -- Adds pretty icons to your documents
				config = {
					folds = false,
				},
			},
			["core.export"] = {}, -- Allows exporting of .norg file to other supported filetypes
			["core.dirman"] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						personal = M.base_directory .. "/personal",
						work = M.base_directory .. "/work",
					},
					default_workspace = "personal",
				},
			},
		},
	}

	require("neorg").setup(opts)
end

return M
