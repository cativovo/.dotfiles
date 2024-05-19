return {
  "iamcco/markdown-preview.nvim",
  config = function()
    vim.g.mkdp_auto_close = 0
    vim.cmd([[do FileType]])
  end,
}
