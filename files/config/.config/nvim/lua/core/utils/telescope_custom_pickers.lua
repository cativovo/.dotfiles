local M = {}

M.neorg = {
	open_workspace = function()
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local conf = require("telescope.config").values
		local dirman = require("neorg").modules.get_module("core.dirman")

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
	end,
}

return M
