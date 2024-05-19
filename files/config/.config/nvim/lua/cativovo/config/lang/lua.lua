local M = {}

local opts = {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}

M.lua_ls = {
  opts = opts,
}

M.parsers = {
  'lua',
  'luadoc',
}

-- other tools
M.ensure_installed = {
  'stylua',
}

return M
