local plugins = {
  "wbthomason/packer.nvim",

  "lewis6991/impatient.nvim",

  {
    "nvim-lua/plenary.nvim",
    module = "plenary"
  },

  { "kyazdani42/nvim-web-devicons" },
  {
    "kyazdani42/nvim-tree.lua",
    opt = true,
    cmd = "NvimTreeToggle",
    setup = function()
      require("plugins.configs.nvimtree").load_keymaps()
    end,
    config = function()
      require("plugins.configs.nvimtree").config()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opt = true,
    cmd = "Telescope",
    module = "telescope",
    setup = function()
      require("plugins.configs.telescope").load_keymaps()
    end,
    config = function()
      require("plugins.configs.telescope").config()
    end,
    requires = { "telescope-fzf-native.nvim", "telescope-ui-select.nvim" }
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  },
  "nvim-telescope/telescope-ui-select.nvim",

  -- TODO fix this
  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    opt = true,
    module = "which-key",
    keys = { "<leader>" },
    config = function()
      require("plugins.configs.whichkey").config()
    end,
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
  {
    "RRethy/vim-illuminate",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("vim-illuminate")
    end,
    config = function()
      require("plugins.configs.illuminate").config()
    end
  },
  "jose-elias-alvarez/null-ls.nvim",

  -- autocomplete/snippet
  {
    "L3MON4D3/LuaSnip",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("LuaSnip")
    end,
    config = function()
      require("plugins.configs.luasnip").config()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("nvim-cmp")
    end,
    config = function()
      require("plugins.configs.cmp").config()
    end,
    after = "LuaSnip",
    requires = {
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("cmp-nvim-lsp")
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("cmp_luasnip")
    end,
  },
  {
    "hrsh7th/cmp-buffer",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("cmp-buffer")
    end
  },
  {
    "hrsh7th/cmp-path",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("cmp-path")
    end
  },

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

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.configs.lualine").config()
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
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("emmet-vim")
    end,
    config = function()
      require("plugins.configs.emmet").config()
    end
  },

  -- comment
  {
    "numToStr/Comment.nvim",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("Comment.nvim")
    end,
    config = function()
      require("plugins.configs.comment").config()
    end
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("nvim-ts-context-commentstring")
    end
  },

  -- git (all plugins related to git have their config in plugins/configs/git.lua)
  {
    "tpope/vim-fugitive",
    opt = true,
    cmd = "Git",
    setup = function()
      require("plugins.configs.git").load_keymaps()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("gitsigns.nvim")
    end,
    config = function()
      require("plugins.configs.git").config()
    end
  },

  -- utils for development
  {
    "iamcco/markdown-preview.nvim",
    opt = true,
    run = require("plugins.configs.markdown_preview").run,
    setup = function()
      require("core.lazy_load").on_file_open("markdown-preview.nvim")
      require("plugins.configs.markdown_preview").setup()
    end,
    ft = require("plugins.configs.markdown_preview").ft,
  },
  {
    "tpope/vim-surround",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("vim-surround")
    end,
  },
  {
    "editorconfig/editorconfig-vim",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open("editorconfig-vim")
    end,
  },

  -- dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua api
  {
    "folke/lua-dev.nvim",
    module = "lua-dev",
    ft = { "lua" },
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
