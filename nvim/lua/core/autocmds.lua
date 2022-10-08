local M = {}
local autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup



M.load = function()
  -- general autocmds
  autocmd("TextYankPost",
    {
      pattern = "*",
      desc = "Highlight text on yank",
      callback = function()
        require("vim.highlight").on_yank({ higroup = "Search", timeout = 30 })
      end,
    }
  )

  autocmd("InsertLeave",
    {
      pattern = "*.*",
      desc = "Set to rnu",
      command = "set rnu",
    }
  )

  autocmd("InsertEnter",
    {
      pattern = "*",
      desc = "Set to nornu",
      command = "set nornu",
    }
  )

  autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
  })
end

M.augroups = {
  format_on_save = create_augroup("LspFormatOnSave", {})
}

M.events = {
  format_on_save = "BufWritePre"
}

M.format_on_save = function(bufnr)
  vim.api.nvim_create_autocmd(M.events.format_on_save, {
    group = M.augroups.format_on_save,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({
        timeout_ms = 10000,
        filter = function(client)
          -- block format on save if server is tsserver to use null-ls instead
          return client.name ~= "tsserver"
        end,
        bufnr = bufnr,
      })
    end,
  })
end

return M
