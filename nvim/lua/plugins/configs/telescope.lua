local M = {}

local get_opts = function()
  local actions = require("telescope.actions")
  local themes = require("telescope.themes")

  return {
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
    mappings = {
      i = {
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<Down>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<Up>"] = actions.toggle_selection + actions.move_selection_better,
      },
    }
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
end

M.setup = function()
  local telescope = require("telescope")
  telescope.setup(get_opts())

    -- load extensions
  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
end

return M
