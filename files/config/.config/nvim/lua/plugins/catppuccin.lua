return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    integrations = {
      navic = true,
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      harpoon = true,
      mason = true,
      fidget = true,
      flash = true,
    },
  },
}
