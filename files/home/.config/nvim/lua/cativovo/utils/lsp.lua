local M = {}

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
-- https://github.com/LazyVim/LazyVim/blob/d19a0041362f0a862b1bef995844ca07bbae6caf/lua/lazyvim/util/lsp.lua#L25
function M.on_attach(on_attach, id)
  return vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach-' .. id, { clear = true }),
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        return on_attach(client, buffer)
      end
    end,
  })
end

return M
