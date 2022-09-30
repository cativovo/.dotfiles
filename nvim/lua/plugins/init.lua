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
    ft = "alpha",
    cmd = { "NvimTreeToggle" },
    config = function()
      require("plugins.configs.nvimtree").config()
    end,
    setup = function()
      require('core.utils').load_mappings("nvimtree")
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    module = "telescope",
    config = function()
      require("plugins.configs.telescope").config()
    end,
    setup = function()
      require('core.utils').load_mappings("telescope")
    end
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
