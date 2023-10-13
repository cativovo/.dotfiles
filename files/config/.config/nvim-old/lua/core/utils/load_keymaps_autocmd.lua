return function(source, pattern, desc)
	local mappings = source.mappings
	local mapping_opts = source.opts

	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = pattern,
		desc = desc,
		callback = function()
			local which_key = require("which-key")

			which_key.register(mappings, mapping_opts)
		end,
	})
end
