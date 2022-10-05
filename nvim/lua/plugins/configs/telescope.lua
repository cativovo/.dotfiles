local M = {}

local function load_keymaps()
  local present, telescope_builtin = pcall(require, "telescope.builtin")

  if not present then
    return
  end

  local keymaps = {
    n = {
      ["<C-p>"] = { telescope_builtin.find_files, "Find Files" },
      ["<leader>tl"] = { telescope_builtin.live_grep, "Live Grep" },
      ["<leader>tg"] = { telescope_builtin.grep_string, "Grep String" },
      ["<leader>tj"] = { telescope_builtin.jumplist, "Show Jumplist" },
      ["<leader>ts"] = { telescope_builtin.search_history, "Show Search History" },
      ["<leader>tC"] = { telescope_builtin.commands, "Show Available Commands" },
      ["<leader>tc"] = { telescope_builtin.command_history, "Show Command History" },
      ["<leader>tm"] = { telescope_builtin.marks, "Show Marks" },
      ["<leader>tr"] = { telescope_builtin.registers, "Show Registers" },
      ["<leader>tS"] = { telescope_builtin.spell_suggest, "Show Spell Suggestions" },
      ["<leader>b"] = { telescope_builtin.buffers, "Show Buffers" },
    }
  }

  require("core.utils").load_keymaps(keymaps)
end

local function setup()
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

M.config = function()
  setup()
  load_keymaps()
end

return M
