-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local register_keys = function(source, pattern, desc)
  local mappings = source.mappings
  local mapping_opts = source.opts

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = pattern,
    desc = desc,
    callback = function()
      require("which-key").register(mappings, mapping_opts)
    end,
  })
end

-- Save Folds
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "?*",
  command = "silent! mkview",
})
-- Load folds
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "?*",
  command = "silent! loadview",
})
