local M = {}

M.setup = function()
	local opts = {
		highlight = true,
		icons = require("core.icons").kind_icons,
	}

	require("nvim-navic").setup(opts)
end

return M
