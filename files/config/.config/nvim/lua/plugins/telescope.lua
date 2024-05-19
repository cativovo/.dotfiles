local grep_opts = {
  additional_args = {
    "--hidden",
  },
}

-- for lsp_symbols pickers
local symbol_width = 60

return {
  "nvim-telescope/telescope.nvim",
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
    },
    pickers = {
      git_status = {
        previewer = false,
        theme = "dropdown",
      },
      live_grep = grep_opts,
      grep_string = grep_opts,
      find_files = {
        hidden = true,
      },
      lsp_references = {
        show_line = false,
      },
      lsp_document_symbols = {
        symbol_width = symbol_width,
      },
      lsp_dynamic_workspace_symbols = {
        symbol_width = symbol_width,
      },
      buffers = {
        mappings = {
          i = {
            ["<C-c>"] = function(prompt_bufnr)
              require("telescope.actions").delete_buffer(prompt_bufnr)
            end,
          },
        },
      },
    },
  },
}
