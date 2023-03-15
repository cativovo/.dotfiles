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
    e = {
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
      b = {"<cmd>Git blame<cr>", "Blame"},
      c = { "<cmd>Telescope git_commits<cr>", "Commits" },
      B = { "<cmd>Telescope git_branches<cr>", "Branches" },
      S = { "<cmd>Telescope git_stash<cr>", "Stash" },
    }
  }
}

-- Telescope
keymaps.telescope = {
  normal = {
    ["<C-p>"] = { "<cmd>Telescope find_files<cr>", "Find Files" },
    ["<leader>t"] = {
      name = "Telescope",
      l = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      g = { "<cmd>Telescope grep_string<cr>", "Grep String" },
      j = { "<cmd>Telescope jumplist<cr>", "Show Jumplist" },
      s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Show Search History" },
      C = { "<cmd>Telescope commands<cr>", "Show Available Commands" },
      c = { "<cmd>Telescope command_history<cr>", "Show Command History" },
      m = { "<cmd>Telescope marks<cr>", "Show Marks" },
      r = { "<cmd>Telescope registers<cr>", "Show Registers" },
      S = { "<cmd>Telescope spell_suggest<cr>", "Show Spell Suggestions" },
    }
  }
}

return keymaps
