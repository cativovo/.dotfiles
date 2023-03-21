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
		lazy = true,
	},
	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("plugins.configs.nvimtree").setup()
		end,
	},
	-- keymaps
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.configs.whichkey").setup()
		end,
	},
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.configs.telescope").setup()
		end,
		dependencies = {
			{
				-- https://github.com/nvim-telescope/telescope-fzf-native.nvim/issues/96v
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				lazy = false,
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
	},
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.configs.treesitter").setup()
		end,
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("plugins.configs.lsp").setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		config = function()
			require("plugins.configs.lsp.null_ls").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = true,
	},
	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"LuaSnip",
		},
		config = function()
			require("plugins.configs.cmp").setup()
		end,
	},
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		config = function()
			require("plugins.configs.luasnip").setup()
		end,
	},
	-- comment
	{
		"echasnovski/mini.comment",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("plugins.configs.mini_comment").setup()
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.configs.illuminate").setup()
		end,
	},
	-- git integration
	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.configs.gitsigns").setup()
		end,
	},
	-- theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("plugins.configs.theme").setup()
		end,
	},
}

local opts = {}

M.load_plugins = function()
	require("lazy").setup(plugins, opts)
end

return M
