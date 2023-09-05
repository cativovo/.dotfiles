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
		lazy = true,
		config = function()
			require("plugins.configs.whichkey").setup()
		end,
	},
	-- telescope
	{
		cmd = "Telescope",
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.configs.telescope").setup()
		end,
		dependencies = {
			-- extensions
			{
				-- https://github.com/nvim-telescope/telescope-fzf-native.nvim/issues/96
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				lazy = false,
			},
			"nvim-telescope/telescope-ui-select.nvim",
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
	},
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		tag = "v0.9.1",
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
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "BufNewFile" },
		tag = "legacy",
		config = function()
			require("plugins.configs.lsp.progress").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = true,
	},
	{
		"SmiteshP/nvim-navic",
		lazy = true,
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("plugins.configs.navic").setup()
		end,
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
	-- line
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.configs.lualine").setup()
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
	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	-- utils
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = true,
	},
	{
		"mattn/emmet-vim",
		event = { "BufReadPost", "BufNewFile" },
		ft = {
			"css",
			"sass",
			"scss",
			"less",
			"stylus",
			"postcss",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"javascriptreact.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"typescriptreact.tsx",
		},
		config = function()
			require("plugins.configs.emmet").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.configs.indent_blankline").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			require("plugins.configs.mini_indentscope").init()
		end,
		config = function()
			require("plugins.configs.mini_indentscope").setup()
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		event = { "BufReadPre", "BufNewFile" },
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require("plugins.configs.markdown_preview").setup()
		end,
	},
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		cmd = { "Neorg" },
		config = function()
			require("plugins.configs.neorg").setup()
		end,
	},
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		config = function()
			require("plugins.configs.harpoon").setup()
		end,
	},
}

M.load_plugins = function()
	local opts = {
		performance = {
			rtp = {
				---@type string[] list any plugins you want to disable here
				disabled_plugins = {
					"gzip",
					-- "matchit",
					-- "matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
	}
	require("lazy").setup(plugins, opts)
end

return M
