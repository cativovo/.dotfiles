return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
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
