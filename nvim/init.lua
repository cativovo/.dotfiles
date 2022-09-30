-- code copied from:
-- https://github.com/NvChad/NvChad
-- https://github.com/LunarVim/LunarVim

vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require "core"
