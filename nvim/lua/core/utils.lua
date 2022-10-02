local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_keymaps = function(keymaps, mapping_opt)
  for modes, mode_values in pairs(keymaps) do
    -- mode can be comma separated for multiple modes
    -- example(for both insert and select mode): i,s
    modes = vim.split(modes, ',')

    local default_opts = merge_tb("force", { mode = modes, silent = true }, mapping_opt or {})
    for keybind, mapping_info in pairs(mode_values) do
      -- merge default + user opts
      local opts = merge_tb("force", default_opts, mapping_info.opts or {})


      mapping_info.opts, opts.mode = nil, nil
      opts.desc = mapping_info[2] or ""

      vim.keymap.set(modes, keybind, mapping_info[1], opts)
    end
  end
end

M.load_general_keymaps = function()
  local keymaps = require('core.general_keymaps')
  M.load_keymaps(keymaps)
end

return M
