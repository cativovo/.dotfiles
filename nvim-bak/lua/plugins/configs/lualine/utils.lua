local M = {}

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

M.list_registered_linters = function(filetype)
  local present, null_ls_methods = pcall(require, "null-ls.methods")

  if not present then
    return
  end

  local formatter_method = null_ls_methods.internal["DIAGNOSTICS"]
  local registered_providers = M.list_registered_providers_names(filetype)

  return registered_providers[formatter_method] or {}
end

M.get_hl_by_name = function(name)
  return string.format("#%06x", vim.api.nvim_get_hl_by_name(name.group, true)[name.prop])
end

M.list_registered_formatters = function(filetype)
  local present, null_ls_methods = pcall(require, "null-ls.methods")

  if not present then
    return
  end

  local formatter_method = null_ls_methods.internal["FORMATTING"]
  local registered_providers = M.list_registered_providers_names(filetype)

  return registered_providers[formatter_method] or {}
end


return M
