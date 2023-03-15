local M = {}

-- install lazy.nvim if not yet installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		"nvim-lua/plenary.nvim",
		lazy = true
	},
	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("plugins.configs.nvimtree").setup()
		end
	},
	-- keymaps
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.configs.whichkey").setup()
		end
	},


	-- git integration
	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
	},
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.configs.gitsigns").setup()
    end
  }
}

local opts = {}

M.load_plugins = function() 
	require("lazy").setup(plugins, opts)
end

return M
