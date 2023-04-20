return function()
	-- this will register keys of builtin and plugins that are not lazy loaded using events
	-- the keymaps of lazy loaded plugins via events are registered in their config files
	local which_key = require("which-key")
	local keymaps = require("core.keymaps")
	local register_opts = { prefix = "<leader>" }

	-- Builtin
	which_key.register(keymaps.builtin.normal)
	which_key.register(keymaps.builtin.visual, { mode = "v" })
	-- File Explorer
	which_key.register(keymaps.file_explorer.normal, register_opts)
	-- Telescope
	which_key.register(keymaps.telescope.normal)
	-- Git
	which_key.register(keymaps.git.normal, register_opts)
	which_key.register(keymaps.git.visual, { mode = "v" })
end
