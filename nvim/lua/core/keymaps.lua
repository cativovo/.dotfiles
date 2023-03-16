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
local telescope_builtin = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

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
      c = { telescope_builtin.git_commits, "Commits" },
      B = { telescope_builtin.git_branches, "Branches" },
      S = { telescope_builtin.git_stash, "Stash" },
    }
  }
}

-- Telescope
keymaps.telescope = {
  normal = {
    ["<C-p>"] = { telescope_builtin.find_files, "Find Files" },
    ["<leader>t"] = {
      name = "Telescope",
      l = { telescope_builtin.live_grep, "Live Grep" },
      g = { telescope_builtin.grep_string, "Grep String" },
      j = { telescope_builtin.jumplist, "Show Jumplist" },
      s = { telescope_builtin.current_buffer_fuzzy_find, "Show Search History" },
      C = { telescope_builtin.commands, "Show Available Commands" },
      c = { telescope_builtin.command_history, "Show Command History" },
      m = { telescope_builtin.marks, "Show Marks" },
      r = { telescope_builtin.registers, "Show Registers" },
      S = { telescope_builtin.spell_suggest, "Show Spell Suggestions" },
    }
  },
  setup = {
      i = {
        ["<Tab>"] = telescope_actions.move_selection_next,
        ["<S-Tab>"] = telescope_actions.move_selection_previous,
        ["<Down>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_worse,
        ["<Up>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_better,
      },
    }
}

return keymaps
