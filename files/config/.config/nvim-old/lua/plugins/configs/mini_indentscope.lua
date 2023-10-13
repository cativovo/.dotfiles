local M = {}

M.init = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "help", "fugitive", "NvimTree", "lazy", "mason", "qf" },
		callback = function()
			vim.b.miniindentscope_disable = true
		end,
	})
end

M.setup = function()
	local opts = {
		mappings = nil,
		draw = {
			delay = 50,
		},
		symbol = "│",
		options = { try_as_border = true },
	}

	require("mini.indentscope").setup(opts)
end

return M
