return function()
	local autocmds = require("core.autocmds")

	autocmds.toggle_number()
	autocmds.remember_folds()
	autocmds.highlight_on_yank()
	autocmds.disable_comment_copy()
	autocmds.json_to_jsonc()
	autocmds.toggle_lsp_diagnostic()
end