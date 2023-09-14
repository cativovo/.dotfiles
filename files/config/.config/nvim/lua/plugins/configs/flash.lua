local M = {}

M.setup = function()
	local opts = {
		modes = {
			search = {
				enabled = false,
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
