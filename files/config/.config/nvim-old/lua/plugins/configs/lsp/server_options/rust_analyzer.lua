return {
	on_attach = function(_, buffer)
		require("which-key").register(require("core.keymaps").rust.normal, { buffer })
	end,
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
}
