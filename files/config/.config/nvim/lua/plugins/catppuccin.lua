return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      harpoon = true,
      mason = true,
      noice = true,
      notify = true,
      fidget = true,
      flash = true,
      trouble = false,
    },
  },
}
