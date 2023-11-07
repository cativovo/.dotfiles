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
      mappings = {
        Y = "copy_selector",
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
        },
      },
    },
    commands = {
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-6679447
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local vals = {
          ["1 Basename"] = modify(filename, ":r"),
          ["2 Filename"] = filename,
          ["3 Path (CWD)"] = modify(filepath, ":."),
          ["4 Path (HOME)"] = modify(filepath, ":~"),
          ["5 Path"] = filepath,
          ["6 Uri"] = vim.uri_from_fname(filepath),
          ["7 Extension"] = modify(filename, ":e"),
        }

        local options = vim.tbl_filter(function(val)
          return vals[val] ~= ""
        end, vim.tbl_keys(vals))

        if vim.tbl_isempty(options) then
          vim.notify("No values to copy", vim.log.levels.WARN)
          return
        end

        table.sort(options)

        vim.ui.select(options, {
          prompt = "Choose to copy to clipboard:",
          format_item = function(item)
            return ("%s: %s"):format(item, vals[item])
          end,
        }, function(choice)
          local result = vals[choice]
          if result then
            vim.fn.setreg("+", result)
            vim.notify(("Copied: `%s`"):format(result))
          end
        end)
      end,
    },
  },
}
