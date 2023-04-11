local M = {}

M.setup = function()
	local icons = require("core.config").icons
	local diagnostics = icons.diagnostics

	local signs = {
		{ name = "DiagnosticSignWarn", text = diagnostics.warning },
		{ name = "DiagnosticSignError", text = diagnostics.error },
		{ name = "DiagnosticSignHint", text = diagnostics.hint },
		{ name = "DiagnosticSignInfo", text = diagnostics.info },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local opts = {
		virtual_text = false,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(opts)
end

return M
