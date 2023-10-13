local M = {}

local list_registered_providers_names = function(filetype)
	local null_ls_sources = require("null-ls.sources")

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

local list_registered_linters = function(filetype)
	local null_ls_methods = require("null-ls.methods")

	local formatter_method = null_ls_methods.internal["DIAGNOSTICS"]
	local registered_providers = list_registered_providers_names(filetype)

	return registered_providers[formatter_method] or {}
end

local list_registered_formatters = function(filetype)
	local null_ls_methods = require("null-ls.methods")

	local formatter_method = null_ls_methods.internal["FORMATTING"]
	local registered_providers = list_registered_providers_names(filetype)

	return registered_providers[formatter_method] or {}
end

M.get_name = function(msg)
	local remove_duplicate = require("core.utils.remove_duplicate")

	msg = msg or "Inactive"
	local buf_clients = vim.lsp.buf_get_clients()
	if next(buf_clients) == nil then
		if type(msg) == "boolean" or #msg == 0 then
			return "Inactive"
		end
		return msg
	end
	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	local supported_formatters = list_registered_formatters(buf_ft)
	vim.list_extend(buf_client_names, supported_formatters)

	local supported_linters = list_registered_linters(buf_ft)
	vim.list_extend(buf_client_names, supported_linters)

	return "[" .. table.concat(remove_duplicate(buf_client_names), ", ") .. "]"
end

return M
