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
  local keymaps = require("core.general_keymaps")
  M.load_keymaps(keymaps)
end

M.format_on_save = function(bufnr)
  vim.lsp.buf.format({
    timeout_ms = 10000,
    filter = function(client)
      -- block format on save if server is tsserver to use null-ls instead
      return client.name ~= "tsserver"
    end,
    bufnr = bufnr,
  })
end

-- https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/lsp/utils.lua#L183
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
M.disable_format_on_save = function(bufnr)
  local autocmds = require("core.autocmds")
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.api.nvim_clear_autocmds({
    group = autocmds.augroups.format_on_save,
    buffer = bufnr
  })
end

M.enable_format_on_save = function(bufnr)
  local autocmds = require("core.autocmds")
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_active_clients({
    bufnr = bufnr,
  })

  for _, client in ipairs(clients) do
    if client.supports_method("textDocument/formatting") then
      -- clear existing LspFormatOnSave augroup before creating new one
      M.disable_format_on_save(bufnr)
      autocmds.format_on_save(bufnr, M.format_on_save)
    end
  end

end

-- https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/autocmds.lua#L178
M.toggle_format_on_save = function()
  local autocmds = require("core.autocmds")

  local exists, current_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = autocmds.augroups.format_on_save,
    event = autocmds.events.format_on_save,
  })

  if not exists or #current_autocmds == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

return M
