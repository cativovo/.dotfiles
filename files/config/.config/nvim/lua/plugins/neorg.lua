local open_workspace = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  local dirman = require("neorg").modules.get_module("core.dirman")
  dirman = dirman or {}

  local workspaces = {}

  for workspace, _ in pairs(dirman.get_workspaces()) do
    table.insert(workspaces, workspace)
  end

  local opts = require("telescope.themes").get_dropdown({})

  pickers
    .new(opts, {
      prompt_title = "Neorg Workspaces",
      finder = finders.new_table({
        results = workspaces,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()

          dirman.open_workspace(selection[1])
        end)

        return true
      end,
    })
    :find()
end

local get_base_directory = function()
  return "~/notes"
end

local M = {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  cmd = "Neorg",
  keys = {
    { "<leader>nw", open_workspace, desc = "Neorg Workspaces" },
    { "<leader>no", "<cmd>Neorg<cr>", desc = "Open Neorg" },
  },
  base_directory = get_base_directory(),
  opts = function()
    local base_directory = get_base_directory()

    return {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = { -- Adds pretty icons to your documents
          config = {
            folds = false,
          },
        },
        ["core.export"] = {}, -- Allows exporting of .norg file to other supported filetypes
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              personal = base_directory .. "/personal",
              work = base_directory .. "/work",
            },
            default_workspace = "personal",
          },
        },
      },
    }
  end,

  -- used in tmux
  open_workspace = open_workspace,
}

return M
