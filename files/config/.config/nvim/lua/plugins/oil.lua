return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    {
      "<leader>o",
      "<cmd>Oil<cr>",
      desc = "Oil",
    },
  },
  opts = {
    -- https://github.com/stevearc/oil.nvim#options
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-p>"] = false,
      ["<C-s>"] = false,
      ["<C-t>"] = false,
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-x>"] = "actions.select_split",
      ["<leader>r"] = "actions.refresh",
      ["<leader>y"] = "actions.copy_entry_path",
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
