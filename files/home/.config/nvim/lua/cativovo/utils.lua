local M = {}

function M.extend(t, key, values)
  local keys = vim.split(key, '.', { plain = true })
  for i = 1, #keys do
    local k = keys[i]
    t[k] = t[k] or {}
    if type(t) ~= 'table' then
      return
    end
    t = t[k]
  end
  return vim.list_extend(t, values)
end

function M.get_pkg_path(pkg, path, opts)
  pcall(require, 'mason') -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ''
  return root .. '/packages/' .. pkg .. '/' .. path
end

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
-- https://github.com/LazyVim/LazyVim/blob/d19a0041362f0a862b1bef995844ca07bbae6caf/lua/lazyvim/util/lsp.lua#L25
function M.on_lsp_attach(on_attach, id)
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

-- https://github.com/LazyVim/LazyVim/blob/8a340511774b93c6dd75368960ebbb44aa58df5c/lua/lazyvim/util/toggle.lua#L76
---@type {k:string, v:any}[]
M._maximized = nil
---@param state boolean?
function M.maximize(state)
  if state == (M._maximized ~= nil) then
    return
  end
  if M._maximized then
    for _, opt in ipairs(M._maximized) do
      vim.o[opt.k] = opt.v
    end
    M._maximized = nil
    vim.cmd('wincmd =')
  else
    M._maximized = {}
    local function set(k, v)
      table.insert(M._maximized, 1, { k = k, v = vim.o[k] })
      vim.o[k] = v
    end
    set('winwidth', 999)
    set('winheight', 999)
    set('winminwidth', 10)
    set('winminheight', 4)
    vim.cmd('wincmd =')
  end
  -- `QuitPre` seems to be executed even if we quit a normal window, so we don't want that
  -- `VimLeavePre` might be another consideration? Not sure about differences between the 2
  vim.api.nvim_create_autocmd('ExitPre', {
    once = true,
    group = vim.api.nvim_create_augroup('lazyvim_restore_max_exit_pre', { clear = true }),
    desc = 'Restore width/height when close Neovim while maximized',
    callback = function()
      M.maximize(false)
    end,
  })
end

return M
