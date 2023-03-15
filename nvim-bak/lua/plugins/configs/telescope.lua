local M = {}

local function setup()
  local present, telescope = pcall(require, "telescope")

  if not present then
    return
  end

  local actions_present, actions = pcall(require, "telescope.actions")

  if not actions_present then
    return
  end

  local telescope_themes_present, themes = pcall(require, "telescope.themes")

  if not telescope_themes_present then
    return
  end

  local options = {
    defaults = {
      file_ignore_patterns = { ".git" },
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        vertical = {
          preview_cutoff = 0,
          prompt_position = "top",
          mirror = true,
          preview_height = .70,
        },
        width = 0.90,
        height = 0.99,
      },
      mappings = {
        i = {
          ["<Tab>"] = actions.move_selection_next,
          ["<S-Tab>"] = actions.move_selection_previous,
          ["<Down>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<Up>"] = actions.toggle_selection + actions.move_selection_better,
        },
      }
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        -- the default case_mode is "smart_case"
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      ["ui-select"] = {
        themes.get_cursor({
          layout_config = {
            width = 0.80,
          },
        })
      }
    },
  }

  telescope.setup(options)

  -- load extensions
  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
end

M.load_keymaps = function()
  local present, telescope_builtin = pcall(require, "telescope.builtin")

  if not present then
    return
  end

  local keymaps = {
    n = {
      ["<C-p>"] = { telescope_builtin.find_files, "Find Files" },
      ["<leader>tl"] = { telescope_builtin.live_grep, "Live Grep" },
      ["<leader>tg"] = { telescope_builtin.grep_string, "Grep String" },
      ["<leader>tj"] = { telescope_builtin.jumplist, "Show Jumplist" },
      ["<leader>ts"] = { telescope_builtin.current_buffer_fuzzy_find, "Show Search History" },
      ["<leader>tC"] = { telescope_builtin.commands, "Show Available Commands" },
      ["<leader>tc"] = { telescope_builtin.command_history, "Show Command History" },
      ["<leader>tm"] = { telescope_builtin.marks, "Show Marks" },
      ["<leader>tr"] = { telescope_builtin.registers, "Show Registers" },
      ["<leader>tS"] = { telescope_builtin.spell_suggest, "Show Spell Suggestions" },
      ["<leader>b"] = { telescope_builtin.buffers, "Show Buffers" },

      -- lsp stuff
      -- go to
      ["<leader>lgd"] = { telescope_builtin.lsp_definitions, "Definition" },
      ["<leader>lgt"] = { telescope_builtin.lsp_type_definitions, "Type Definition" },
      ["<leader>lgi"] = { telescope_builtin.lsp_implementations, "Implementation" },
      ["<leader>lgr"] = { telescope_builtin.lsp_references, "Reference" },

      ["<leader>ld"] = {
        function()
          telescope_builtin.diagnostics({ bufnr = 0, theme = "get_ivy" })
        end,
        "Buffer Diagnostics"
      },
      ["<leader>lw"] = { telescope_builtin.diagnostics, "Diagnostics" },

      ["<leader>ls"] = { telescope_builtin.lsp_document_symbols, "Document Symbols" },
      ["<leader>lS"] = { telescope_builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols" },
      ["<leader>le"] = { telescope_builtin.quickfix, "Telescope Quickfix" },

      -- git
      ["<leader>gc"] = { telescope_builtin.git_commits, "Commits" },
      ["<leader>gB"] = { telescope_builtin.git_branches, "Branches" },
      ["<leader>gS"] = { telescope_builtin.git_stash, "Stash" },
    }
  }

  require("core.utils").load_keymaps(keymaps)
end


M.config = function()
  setup()
end

return M
