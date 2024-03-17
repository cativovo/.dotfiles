return {
  "cbochs/grapple.nvim",
  event = "VeryLazy",
  config = true,
  keys = {
    { "<leader>fa", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
    { "<leader>fm", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
    { "<leader>fj", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
    { "<leader>fk", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
    { "<leader>fl", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
    { "<leader>f;", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
  },
}
