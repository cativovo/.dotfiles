local M = {}

local function setup()
  local present, lualine = pcall(require, "lualine")

  if not present then
    return
  end

  local status = require("plugins.configs.lualine.status")
  local conditions = require("plugins.configs.lualine.conditions")

  local config = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "NvimTree", "neo-tree", "dashboard", "Outline" },
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = {},
      lualine_b = {
        {
          "branch",
          color = {
            gui = "bold",
          },
        },
        {
          "diff",
          cond = conditions.hide_in_width,
          symbols = { added = " ", modified = "~ ", removed = " " },
        },
      },
      lualine_c = { { "filename", file_status = true, path = 1 } },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
          padding = { left = 2, right = 1 },
        },
      },
      lualine_y = {
        {
          status.treesitter_status,
          padding = { left = 0, right = 0 },
          cond = conditions.hide_in_width,
        },
        {
          status.lsp_progress,
          color = { gui = "none" },
          padding = { left = 1, right = 1 },
          cond = conditions.hide_in_width,
        },
        {
          status.lsp_name,
          color = { gui = "none" },
          padding = { left = 1, right = 1 },
          cond = conditions.hide_in_width,
        },
        {
          "filetype",
          cond = conditions.buffer_not_empty,
          padding = { left = 0, right = 1 },
        },
      },
      lualine_z = {
        {
          "progress",
          separator = "",
          padding = { left = 1, right = 0 },
        },
        {
          function()
            -- show current line / total line(s)
            return unpack(vim.api.nvim_win_get_cursor(0)) .. "/" .. vim.api.nvim_buf_line_count(0)
          end,
          padding = { left = 1, right = 1 },
        }
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }

  lualine.setup(config)
end

function M.config()
  setup()
end

return M
