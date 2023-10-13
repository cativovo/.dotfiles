local M = {}

M.setup = function()
	require("harpoon").setup()
	require("which-key").register(require("core.keymaps").harpoon, { prefix = "<leader>" })
end

return M
