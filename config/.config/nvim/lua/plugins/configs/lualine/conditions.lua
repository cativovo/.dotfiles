local M = {}

M.buffer_not_empty = function()
	return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

M.hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

return M
