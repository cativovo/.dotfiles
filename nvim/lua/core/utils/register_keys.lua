return function()
	local which_key = require("which-key")
	local telescope_builtin = require("telescope.builtin")
	local keymaps = require("core.keymaps")
	local register_opts = { prefix = "<leader>" }

	-- Builtin
	which_key.register(keymaps.builtin.normal)
	which_key.register(keymaps.builtin.visual, { mode = "v" })
	-- File Explorer
	which_key.register(keymaps.file_explorer.normal, register_opts)
	-- Telescope
	which_key.register(keymaps.telescope.get("normal", telescope_builtin))
	-- Git
	which_key.register(keymaps.git.get("normal", telescope_builtin), register_opts)
	-- Illuminate
	which_key.register(keymaps.illuminate.get("normal", require("illuminate")))
end
