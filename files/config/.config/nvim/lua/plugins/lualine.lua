local icons = require("lazyvim.config").icons

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_a = {},
      lualine_c = {
        { "filename", path = 1, symbols = { modified = " " } },
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
      },
      lualine_y = {
        { "progress" },
        { "location" },
      },
      lualine_z = {
        {
          function()
            return "Lines: " .. vim.fn.line("$")
          end,
        },
      },
    },
    winbar = {
      lualine_a = { "mode" },
      lualine_c = {
        {
          "navic",
          cond = function()
            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          end,
        },
      },
    },
    inactive_winbar = {
      lualine_a = { "mode" },
    },
  },
}
