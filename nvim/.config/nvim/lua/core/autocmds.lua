local config = require("core.config")
local format = require("plugins.configs.lsp.format")
local M = {}

M.autoformat = function(buffer)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LspFormat." .. buffer, {}),
		buffer = buffer,
		callback = function()
			if config.autoformat then
				format()
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

M.remember_folds = function()
	local group = vim.api.nvim_create_augroup("RememberFolds", {})

	vim.api.nvim_create_autocmd({ "BufLeave", "BufWritePre" }, {
		group = group,
		pattern = "*.*",
		command = "silent! mkview",
	})

	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = group,
		pattern = "*",
		command = "silent! loadview",
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

M.toggle_lsp_diagnostic = function()
	local group = vim.api.nvim_create_augroup("ToggleDiagnostic", {})

	vim.api.nvim_create_autocmd("InsertLeave", {
		group = group,
		buffer = buffer,
		desc = "Enable LSP diagnostics",
		callback = function()
			vim.defer_fn(function()
				if vim.fn.mode() == "n" then
					vim.diagnostic.enable()
				end
			end, 350)
		end,
	})

	vim.api.nvim_create_autocmd("InsertEnter", {
		group = group,
		desc = "Disable LSP diagnostics",
		callback = function()
			vim.diagnostic.disable()
		end,
	})
end

return M