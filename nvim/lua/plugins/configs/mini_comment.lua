local M = {}

M.setup = function()
	local opts = {
		mappings = require("core.keymaps").comment.setup,
		hooks = {
			pre = function()
				require("ts_context_commentstring.internal").update_commentstring()
			end,
		},
	}

	require("mini.comment").setup(opts)
end

return M
