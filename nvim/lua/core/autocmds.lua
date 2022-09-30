local M = {}
local autocmd = vim.api.nvim_create_autocmd



M.load = function()
  autocmd("TextYankPost",
    {
      pattern = "*",
      desc = "Highlight text on yank",
      callback = function()
        require("vim.highlight").on_yank { higroup = "Search", timeout = 30 }
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
      pattern = "*.*",
      desc = "Set to nornu",
      command = "set nornu",
    }
  )
end

return M
