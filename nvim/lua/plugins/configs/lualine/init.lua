local M = {}

M.setup = function()
	local lsp = require("plugins.configs.lualine.lsp")
	local conditions = require("plugins.configs.lualine.conditions")
	local utils = require("plugins.configs.lualine.utils")
	local icons = require("core.config").icons

	local opts = {
		options = {
			theme = "auto",
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
		},
		sections = {
			lualine_a = {},
			lualine_b = { "branch" },
			lualine_c = {
				{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
			},
			lualine_x = {
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = utils.fg("Special"),
				},
				{
					lsp.get_progress,
					color = { gui = "none" },
					padding = { left = 1, right = 1 },
					cond = conditions.hide_in_width,
				},
				{
					lsp.get_name,
					color = { gui = "none" },
					padding = { left = 1, right = 1 },
					cond = conditions.hide_in_width,
				},
			},
			lualine_y = {
				{
					"diagnostics",
					symbols = {
						error = icons.diagnostics.error,
						warn = icons.diagnostics.warn,
						info = icons.diagnostics.info,
						hint = icons.diagnostics.hint,
					},
				},
				{
					"diff",
					symbols = {
						added = icons.git.added,
						modified = icons.git.modified,
						removed = icons.git.removed,
					},
				},
			},
			lualine_z = {
				{ "progress", separator = " ", padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
		},
		extensions = { "nvim-tree", "fugitive" },
	}
	require("lualine").setup(opts)
end

return M
