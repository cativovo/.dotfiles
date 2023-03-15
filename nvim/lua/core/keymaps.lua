local keymaps = {}

-- Builtin
keymaps.builtin = {
  normal = {
    -- Switch between windows
    ["<C-h>"] = { "<C-w>h", "Window Left" },
    ["<C-l>"] = { "<C-w>l", "Window Right" },
    ["<C-j>"] = { "<C-w>j", "Window Down" },
    ["<C-k>"] = { "<C-w>k", "Window Up" },

    -- Save
    ["<C-s>"] = { ":w<CR>", "Save File" },
  },
  visual = {
    -- Move selected line / block of text in visual mode
    ["K"] = { ":move '<-2<CR>gv-gv", "Move Line Up" },
    ["J"] = { ":move '>+1<CR>gv-gv", "Move Line Down" },

    -- Copy text
    ["<leader>y"] = { '"+y', "Copy To Clipboard" },
  },
}


-- Plugins
-- File explorer
keymaps.file_explorer = {
  normal = {
    ["<leader>e"] = {
      "<cmd>NvimTreeToggle<cr>",
      "Toggle File Explorer"
    }
  }
}

-- Git
keymaps.git = {
  normal = {
    g = {
      name = "Git",
      s = {"<cmd>Git<cr>", "Source Control"},
      b = {"<cmd>Git blame<cr>", "Blame"}
    }
  }
}

return keymaps
