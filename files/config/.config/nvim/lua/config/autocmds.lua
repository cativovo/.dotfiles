-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local register_keys = function(source, pattern, desc)
  local mappings = source.mappings
  local mapping_opts = source.opts

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = pattern,
    desc = desc,
    callback = function()
      require("which-key").register(mappings, mapping_opts)
    end,
  })
end

-- Save Folds
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "?*",
  command = "silent! mkview",
})
-- Load folds
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "?*",
  command = "silent! loadview",
})

-- Neorg
register_keys({
  mappings = {
    n = {
      x = {
        name = "Export",
        f = {
          "<cmd>Neorg export to-file ",
          "To file",
          silent = false,
        },
        d = {
          "<cmd>Neorg export directory ",
          "Directory",
          silent = false,
        },
        buffer = 0,
      },
      e = {
        "<cmd>NvimTreeToggle" .. require("plugins.neorg").base_directory .. "<cr>",
        "Explorer",
        buffer = 0,
      },
      q = {
        "<cmd>Neorg return<cr>",
        "Quit",
        buffer = 0,
      },
      f = {
        function()
          require("telescope.builtin").find_files({
            cwd = require("neorg").modules.get_module("core.dirman").get_current_workspace()[2],
          })
        end,
        "Find Note",
        buffer = 0,
      },
      l = {
        function()
          require("telescope.builtin").live_grep({
            cwd = require("neorg").modules.get_module("core.dirman").get_current_workspace()[2],
          })
        end,
        "Live Grep Notes",
        buffer = 0,
      },
    },
  },
  opts = { prefix = "<leader>" },
}, "*.norg", "Register Neorg keys")
