return {
	on_attach = function(_, buffer)
		require("which-key").register(require("core.keymaps").lsp.eslint, { buffer })
	end,
}
