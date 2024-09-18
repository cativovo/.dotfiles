local M = {}

local path = {
  exists = function(filename)
    local stat = vim.uv.fs_stat(filename)
    return stat ~= nil
  end,
  join = function(...)
    local path_separator = '/'
    return table.concat(vim.iter({ ... }):flatten():totable(), path_separator):gsub(path_separator .. '+', path_separator)
  end,
}

M.root_has_file = function(...)
  local patterns = vim.iter({ ... }):flatten():totable()
  local root = vim.uv.cwd()
  for _, name in ipairs(patterns) do
    if path.exists(path.join(root, name)) then
      return true
    end
  end
  return false
end

return M
