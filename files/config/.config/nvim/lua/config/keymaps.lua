-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- DISABLED
-- remove terminal keymaps
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

-- remove new file keymap
vim.keymap.del("n", "<leader>fn")

-- remove tabs keymamps
vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader><tab>[")

-- remove lazygit keymaps
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")

-- remove buffer keymaps
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")

-- remove diagnostics keymaps
vim.keymap.del("n", "<leader>xl")
vim.keymap.del("n", "<leader>xq")

-- remove quit all keymaps
vim.keymap.del("n", "<leader>qq")

-- MY KEYS
-- quickfix list
vim.keymap.set("n", "<leader>qo", "<cmd>copen<cr>", { desc = "Open Quickfix List" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "Close Quickfix List" })
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<cr>", { desc = "Next Item" })
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<cr>", { desc = "Previous Item" })

-- copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy To Clipboard" })
