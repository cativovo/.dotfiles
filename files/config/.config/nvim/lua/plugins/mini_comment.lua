return {
  "echasnovski/mini.comment",
  opts = {
    mappings = {
      -- macos
      comment = "<C-_>",
      comment_line = "<C-_>",
      comment_visual = "<C-_>",
      -- linux
      -- comment = "<C-/>",
      -- comment_line = "<C-/>",
      -- comment_visual = "<C-/>",
      textobject = "gc",
    },
  },
  config = function(_, opts)
    vim.schedule(function()
      require("mini.comment").setup(opts)
    end)
  end,
}
