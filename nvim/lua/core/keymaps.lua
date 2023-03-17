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
    },
    ["<leader>b"] = { telescope_builtin.buffers, "Show Buffers" },
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

-- Treesitter
keymaps.treesitter = {
  setup = {
    init_selection = "<C-Space>",
    node_incremental = "<C-Space>",
    scope_incremental = "grc",
    node_decremental = "<BS>",
  }
}

-- LSP
keymaps.lsp = {
  normal = {
    ["<leader>l"] = {
      name = "LSP",
      g = {
        name = "Go to",
        d = { telescope_builtin.lsp_definitions, "Definition" },
        t = { telescope_builtin.lsp_type_definitions, "Type Definition" },
        i = { telescope_builtin.lsp_implementations, "Implementation" },
        r = { telescope_builtin.lsp_references, "Reference" },
      },
      d = {
        function()
          telescope_builtin.diagnostics({ bufnr = 0, theme = "get_ivy" })
        end,
        "Buffer Diagnostics"
      },
      s = { telescope_builtin.lsp_document_symbols, "Document Symbols" },
      S = { telescope_builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols" },
      {
      a = { vim.lsp.buf.code_action, "Code Action" },
      -- for non mac os
      -- ["<A-p>"] = {
      -- utils.format_on_save,
      --   "Format"
      -- },
    --  ["π"] = {
    --    utils.format_on_save,
    --    "Format"
    --  },
      i = { ":LspInfo<CR>", "Info" },
      I = { ":Mason<CR>", "Mason Info" },
      r = { vim.lsp.buf.rename, "Rename" },
      l = {
        function()
          vim.diagnostic.open_float(0, { scope = 'line' })
        end,
        "Show Current Line Diagnostic"
      },
    }
    }, 
    {
      K = { vim.lsp.buf.hover, "Show hover" },
      -- non macbook mappings
      -- ["<A-l>"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      -- ["<A-h>"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      -- macbook mappings
      ["¬"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      ["˙"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
    }
  }
}

return keymaps
