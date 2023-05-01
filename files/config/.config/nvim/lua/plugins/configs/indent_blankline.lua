local M = {}

M.setup = function()
	local opts = {
		-- char = "▏",
		char = "│",
		filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
		show_trailing_blankline_indent = false,
		show_current_context = false,
	}

	require("indent_blankline").setup(opts)
end

return M
