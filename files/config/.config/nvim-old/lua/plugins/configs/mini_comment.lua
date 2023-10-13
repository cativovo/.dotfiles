local M = {}

M.setup = function()
	local opts = {
		mappings = require("core.keymaps").comment.setup,
		options = {
			custom_commentstring = function()
				return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
			end,
		},
	}

	require("mini.comment").setup(opts)
end

return M
