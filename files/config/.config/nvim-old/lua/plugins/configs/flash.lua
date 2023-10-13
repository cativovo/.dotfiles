local M = {}

M.setup = function()
	local opts = {
		label = {
			after = false,
			before = true,
		},
		modes = {
			search = {
				highlight = {
					backdrop = true,
				},
			},
			char = {
				enabled = false,
			},
		},
	}

	local flash = require("flash")

	flash.setup(opts)
	require("which-key").register(require("core.keymaps").flash.setup(flash))
end

return M
