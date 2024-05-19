return {
  'catppuccin/nvim',
  name = 'catppuccin',
  opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = {
      light = 'latte',
      dark = 'mocha',
    },
    transparent_background = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      telescope = true,
      mason = true,
      flash = true,
    },
  },
  init = function()
    vim.cmd.colorscheme('catppuccin')
  end,
}
