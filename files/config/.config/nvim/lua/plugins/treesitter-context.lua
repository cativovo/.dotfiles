return {
  "nvim-treesitter/nvim-treesitter-context",
  opts = function()
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = "Grey", underline = true })
  end,
}
