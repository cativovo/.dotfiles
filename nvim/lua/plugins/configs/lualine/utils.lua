local M = {}

M.fg = function(name)
	return function()
		---@type {foreground?:number}?
		local hl = vim.api.nvim_get_hl_by_name(name, true)
		return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
	end
end

M.list_registered_providers_names = function(filetype)
	local present, null_ls_sources = pcall(require, "null-ls.sources")

	if not present then
		return {}
	end

	local available_sources = null_ls_sources.get_available(filetype)
	local registered = {}

	for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
	end

	return registered
end

M.get_hl_by_name = function(name)
	return string.format("#%06x", vim.api.nvim_get_hl_by_name(name.group, true)[name.prop])
end

return M
