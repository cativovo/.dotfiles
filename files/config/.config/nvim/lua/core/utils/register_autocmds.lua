return function()
	local autocmds = require("core.autocmds")

	autocmds.toggle_number()
	autocmds.highlight_on_yank()
	autocmds.disable_comment_copy()
	autocmds.json_to_jsonc()

	-- load keymaps via autocmd
	local keymaps = require("core.keymaps")
	local load_keymaps_autocmd = require("core.utils.load_keymaps_autocmd")

	load_keymaps_autocmd({
		mappings = keymaps.neorg.autocmd,
		opts = { prefix = "<leader>" },
	}, "*.norg", "Load Neorg keymaps")
end
