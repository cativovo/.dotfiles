-- TODO add labels
local plugins = {
  "wbthomason/packer.nvim",

  "lewis6991/impatient.nvim",

  {
    "nvim-lua/plenary.nvim",
    module = "plenary"
  },

  {
    "kyazdani42/nvim-tree.lua",
    -- ft = "alpha",
    -- cmd = { "NvimTreeToggle" },
    config = function()
      require("plugins.configs.nvimtree").config()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    -- cmd = "Telescope",
    -- module = "telescope",
    config = function()
      require("plugins.configs.telescope").config()
    end,
  },

  -- TODO fix this
  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    -- disable = true,
    -- module = "which-key",
    -- keys = { "<leader>", '"', "'", "`" },
    config = function()
      require("plugins.configs.whichkey").config()
    end,
    -- setup = function()
    -- require("core.utils").load_mappings("whichkey")
    -- end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    config = function()
      require("plugins.configs.lsp.mason").config()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugins.configs.lsp.mason_lsp").config()
    end
  },
  {
    "neovim/nvim-lspconfig",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("nvim-lspconfig")
    end,
    config = function()
      require("plugins.configs.lsp").config()
    end,
  },
  "jose-elias-alvarez/null-ls.nvim",

  -- autocomplete/snippet
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.configs.cmp").config()
    end,
    requires = {
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins.configs.luasnip").config()
    end,
  },
  "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    setup = function()
      require("core.lazy_load").on_file_open("nvim-treesitter")
    end,
    config = function()
      require("plugins.configs.treesitter").config()
    end
  },

  -- theme
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("plugins.configs.theme").config()
    end
  },

  {
    "mattn/emmet-vim",
    config = function()
      require("plugins.configs.emmet").config()
    end
  },

  -- dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua api
  {
    "folke/lua-dev.nvim",
    module = "lua-dev",
  },
}

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print('Cloning packer...')
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local present, packer = pcall(require, "packer")

if present then
  packer.startup(function(use)
    for _, v in pairs(plugins) do
      use(v)
    end

    if packer_bootstrap then
      packer.sync()
    end
  end
  )
end
