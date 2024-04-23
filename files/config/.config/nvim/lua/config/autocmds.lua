-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  command = "setlocal number",
})

vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  command = "setlocal nornu",
})

vim.api.nvim_create_autocmd("FocusGained", {
  pattern = "*",
  command = "setlocal rnu",
})
