return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return {
      sections = {
        lualine_a = {},
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return "Lines: " .. vim.fn.line("$")
            end,
            padding = { left = 1, right = 1 },
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
    }
  end,
}
