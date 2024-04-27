return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { link = "Cursorline" })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { link = "Cursorline" })
    require("treesitter-context").setup(opts)
  end,
  opts = {
    max_lines = 6,
  },
}
