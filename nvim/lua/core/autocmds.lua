local M = {}
local autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

M.augroups = {
  format_on_save = create_augroup("LspFormatOnSave", {}),
  toggle_number = create_augroup("ToggleNumber", {}),
  remember_folds = create_augroup("RememberFolds", {}),
}

M.events = {
  format_on_save = "BufWritePre"
}

-- augroups
M.format_on_save = function(bufnr, callback)
  autocmd(M.events.format_on_save, {
    group = M.augroups.format_on_save,
    buffer = bufnr,
    callback = function()
      callback(bufnr)
    end,
  })
end

M.toggle_number = function()
  autocmd("InsertLeave",
    {
      group = M.augroups.toggle_number,
      pattern = "*.*",
      desc = "Set to rnu",
      command = "set rnu",
    }
  )
  autocmd("InsertEnter",
    {
      group = M.augroups.toggle_number,
      pattern = "*.*",
      desc = "Set to nornu",
      command = "set nornu",
    }
  )
end

M.remember_folds = function()
  autocmd({ "BufLeave", M.events.format_on_save }, {
    group = M.augroups.remember_folds,
    pattern = "*.*",
    command = "silent! mkview"
  })
  autocmd("BufWinEnter", {
    group = M.augroups.remember_folds,
    pattern = "*.*",
    command = "silent! loadview"
  })
end

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

  autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
  })

  M.toggle_number()
  M.remember_folds()
end

return M
