local M = {}

local themes = require("telescope.themes")
local keymaps = require("core.keymaps")

local opts =  {
  defaults = {
    file_ignore_patterns = { ".git" },
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        preview_cutoff = 0,
        prompt_position = "top",
        mirror = true,
        preview_height = .70,
      },
      width = 0.90,
      height = 0.99,
    },
    mappings = keymaps.telescope.setup
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      -- the default case_mode is "smart_case"
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    ["ui-select"] = {
      themes.get_cursor({
        layout_config = {
          width = 0.80,
        },
      })
    }
  },
}

M.setup = function()
  local telescope = require("telescope")
  telescope.setup(opts)

  -- load extensions
  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
end

return M
