local config = require("core.config")
local format = require("plugins.configs.lsp.format")
local M = {}

M.autoformat = function(buf)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
		buffer = buf,
		callback = function()
			if config.autoformat then
				format()
			end
		end,
	})
end

return M
