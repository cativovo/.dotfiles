local keymaps = {}

-- File explorer
keymaps.file_explorer = {
  ["<leader>e"] = {
    "<cmd>NvimTreeToggle<cr>",
    "Toggle File Explorer"
  }
}

-- Git
keymaps.git = {
  g = {
    name = "Git",
    s = {"<cmd>Git<cr>", "Source Control"},
    b = {"<cmd>Git blame<cr>", "Blame"}
  }
}

return keymaps
