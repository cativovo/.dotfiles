local M = {}

function GetCurrentQuickfixIndex()
	local current_line = vim.fn.line(".")
	local quickfix_list = vim.fn.getqflist()

	for idx in ipairs(quickfix_list) do
		if idx == current_line then
			return idx - 1
		end
	end

	return -1 -- Item not found
end

function RemoveQuickfixItem(index)
	local original_list = vim.fn.getqflist()

	if index >= 0 and index < #original_list then
		local new_list = vim.deepcopy(original_list)
		table.remove(new_list, index + 1)
		vim.fn.setqflist(new_list, "r")
	else
		print("Invalid index")
	end
end

M.RemoveQuickfixItemByCursor = function()
	local index = GetCurrentQuickfixIndex()
	if index >= 0 then
		RemoveQuickfixItem(index)
	else
		print("Current item not found in quickfix list")
	end
end

return M
