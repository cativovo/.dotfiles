local icons = require("lazyvim.config").icons

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      disabled_filetypes = { statusline = { "lazy" } },
    },
    sections = {
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
    extensions = {
      "lazy",
      "man",
      "neo-tree",
      "nvim-dap-ui",
      "quickfix",
    },
  },
}
