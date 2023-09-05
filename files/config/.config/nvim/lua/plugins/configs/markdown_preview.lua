local M = {}

M.setup = function()
	-- set to 1, the nvim will auto close current preview window when change
	-- from markdown buffer to another buffer
	-- default: 1
	vim.g.mkdp_auto_close = 0
end

return M
