local M = {}

M.config = function()
  local present, telescope = pcall(require, "telescope")

  if not present then
    return
  end

  local actions_present, actions = pcall(require, "telescope.actions")

  if not actions_present then
    return
  end

  local options = {
    defaults = {
      file_ignore_patterns = { ".git" },
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        vertical = {
          prompt_position = "top",
          mirror = true,
          preview_height = .60,
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
    },
  }

  telescope.setup(options)
end

return M
