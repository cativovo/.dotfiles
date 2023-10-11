local M = {}

M.setup = function()
	local opts = {
		indent = {
			char = "│",
			tab_char = "│",
		},
		exclude = {
			filetypes = {
				"help",
				"dashboard",
				"lazy",
				"mason",
			},
		},
		scope = { enabled = false },
	}

	require("ibl").setup(opts)
end

return M
