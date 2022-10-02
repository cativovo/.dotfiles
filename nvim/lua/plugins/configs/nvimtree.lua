local M = {}


local function load_keymaps()
  local keymaps = {
    n = {
      -- toggle
      ["<leader>e"] = { ":NvimTreeToggle<CR>", "Toggle Nvimtree" }
    }
  }

  require("core.utils").load_keymaps(keymaps)
end

local function setup()
  local present, nvimtree = pcall(require, "nvim-tree")

  if not present then
    return
  end

  local options = {
    on_config_done = nil,
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_netrw = true,
    hijack_directories = {
      enable = true,
    },
    update_cwd = true,
    diagnostics = {
      enable = true,
      show_on_dirs = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 200,
    },
    view = {
      width = 30,
      hide_root_folder = false,
      side = "right",
      mappings = {
        custom_only = false,
        list = {},
      },
      number = true,
      relativenumber = true,
      signcolumn = "yes",
    },
    renderer = {
      indent_markers = {
        enable = false,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        show = {
          git = true,
          folder = true,
          file = true,
          folder_arrow = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
          },
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
          },
        },
      },
      highlight_git = true,
      root_folder_modifier = ":t",
    },
    filters = {
      dotfiles = false,
      custom = { "node_modules", "\\.cache" },
      exclude = {},
    },
    trash = {
      cmd = "trash",
      require_confirm = true,
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        diagnostics = false,
        git = false,
        profile = false,
      },
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      open_file = {
        quit_on_open = false,
        resize_window = false,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
    },
  }

  vim.g.nvimtree_side = options.view.side

  nvimtree.setup(options)
end

M.config = function()
  setup()
  load_keymaps()
end

return M
