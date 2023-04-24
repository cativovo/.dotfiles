local M = {}

M.setup = function() end
local opts = {
	text = {
		spinner = "dots",
	},
	timer = {
		task_decay = 500,
		fidget_decay = 500,
	},
	window = {
		blend = 0, -- make background transparent
	},
}

require("fidget").setup(opts)
return M
