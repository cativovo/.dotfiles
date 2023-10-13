return {
  "iamcco/markdown-preview.nvim",
  event = { "BufReadPre", "BufNewFile" },
  ft = "markdown",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.g.mkdp_auto_close = 0
  end,
}
