return {
  "nvim-treesitter/nvim-treesitter-context",
  opts = {
    max_lines = 0, -- <= 0 mean no limit
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = "Grey", underline = true })
    require("treesitter-context").setup(opts)
  end,
}
