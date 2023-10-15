local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  keys = function()
    return {
      { "<C-p>", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files (root dir)" },
      { "<leader>b", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Show Buffers", remap = true },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- git
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    }
  end,
  opts = {
    defaults = {
      file_ignore_patterns = { ".git/" },
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        vertical = {
          preview_cutoff = 0,
          prompt_position = "top",
          mirror = true,
          preview_height = 0.70,
        },
        width = 0.90,
        height = 0.99,
      },
      mappings = {
        i = {
          ["<Tab>"] = function(prompt_bufnr)
            require("telescope.actions").move_selection_next(prompt_bufnr)
          end,
          ["<S-Tab>"] = function(prompt_bufnr)
            require("telescope.actions").move_selection_previous(prompt_bufnr)
          end,
        },
      },
      vimgrep_arguments = {
        "rg",
        "--vimgrep",
        "--smart-case",
        "--hidden",
      },
    },
    pickers = {
      git_status = {
        previewer = false,
        theme = "dropdown",
      },
    },
  },
}
