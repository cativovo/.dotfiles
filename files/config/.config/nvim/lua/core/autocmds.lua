local config = require("core.config")
local format = require("plugins.configs.lsp.format")
local M = {}

M.autoformat = function()
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LspFormat", {}),
		callback = function()
			if config.autoformat then
				format({ silent = true })
			end
		end,
	})
end

M.toggle_number = function()
	local group = vim.api.nvim_create_augroup("ToggleNumber", {})
	local is_valid = function()
		return vim.bo.ft ~= "TelescopePrompt"
	end

	vim.api.nvim_create_autocmd("InsertLeave", {
		group = group,
		pattern = "*",
		desc = "Set to rnu",
		callback = function()
			if is_valid() then
				vim.cmd("setlocal rnu")
			end
		end,
	})

	vim.api.nvim_create_autocmd("InsertEnter", {
		group = group,
		pattern = "*",
		desc = "Set to nornu",
		callback = function()
			if is_valid() then
				vim.cmd("setlocal nornu")
			end
		end,
	})
end

M.highlight_on_yank = function()
	vim.api.nvim_create_autocmd("TextYankPost", {
		pattern = "*",
		desc = "Highlight text on yank",
		callback = function()
			vim.highlight.on_yank({ higroup = "Search", timeout = 30 })
		end,
	})
end

M.disable_comment_copy = function()
	vim.api.nvim_create_autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
		pattern = "*",
		command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
	})
end

M.json_to_jsonc = function()
	vim.api.nvim_create_autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
		pattern = "*",
		callback = function()
			if vim.bo.ft == "json" then
				vim.cmd("setlocal filetype=jsonc")
			end
		end,
	})
end

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L29
-- go to last loc when opening a buffer
M.go_to_last_location = function()
	vim.api.nvim_create_autocmd("BufReadPost", {
		callback = function()
			local exclude = { "gitcommit" }
			local buf = vim.api.nvim_get_current_buf()

			if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
				return
			end

			local mark = vim.api.nvim_buf_get_mark(buf, '"')
			local lcount = vim.api.nvim_buf_line_count(buf)

			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end,
	})
end

return M
