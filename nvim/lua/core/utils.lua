local M = {}

M.register_keys = function()
  local which_key = require("which-key")
  local keymaps = require("core.keymaps")
  local opts = { prefix = "<leader>" }

  -- Builtin
  which_key.register(keymaps.builtin.normal)
  which_key.register(keymaps.builtin.visual, { mode = "v" })
  -- File Explorer
  which_key.register(keymaps.file_explorer.normal, opts)
  -- Telescope
  which_key.register(keymaps.telescope.normal)
  -- Git
  which_key.register(keymaps.git.normal, opts)
end

return M
