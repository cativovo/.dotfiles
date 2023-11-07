local Util = require("lazyvim.util")

return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = function()
    return {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
        end,
        desc = "Explorer NeoTree",
        remap = true,
      },
    }
  end,
  opts = {
    window = {
      position = "right",
      auto_expand_width = true,
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
        },
      },
    },
  },
}
