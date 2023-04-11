--local autofix = function()
--	if vim.fn.exists(":EslintFixAll") > 0 then
--		vim.cmd("EslintFixAll")
--	end
--end

-- https://github.dev/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/format.lua#L22
return function()
	print("Formating...")

	local buf = vim.api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype
	local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

	vim.lsp.buf.format({
		timeout_ms = 100000,
		bufnr = buf,
		filter = function(client)
			if have_nls then
				return client.name == "null-ls"
			end
			return client.name ~= "null-ls"
		end,
	})

	--	autofix()

	print("Formating done")
end
