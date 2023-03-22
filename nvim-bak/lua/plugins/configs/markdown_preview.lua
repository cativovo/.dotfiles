local M = {}

M.run = "cd app && npm install"

M.setup = function()
  vim.g.mkdp_filetypes = { "markdown" }
end

M.ft = { "markdown" }

return M
