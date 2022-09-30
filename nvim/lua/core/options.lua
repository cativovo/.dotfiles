local options = {
  completeopt = { "menuone", "noselect" },
  expandtab = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  showmatch = false,
  relativenumber = true,
  number = true,
  hlsearch = false,
  hidden = true,
  errorbells = false,
  smartindent = true,
  wrap = false,
  swapfile = false,
  backup = false,
  incsearch = true,
  termguicolors = true,
  ignorecase = true,
  smartcase = true,
  cursorline = true,
  cmdheight = 2,
  updatetime = 51,
  colorcolumn = "100",
  signcolumn = "yes",
  splitright = true,
  splitbelow = false,
  showtabline = 0,
  clipboard = "",
  undofile = false,
  scrolloff = 0,
  timeoutlen = 500,
}


local opt = vim.opt

for key, value in pairs(options) do
  opt[key] = value
end
