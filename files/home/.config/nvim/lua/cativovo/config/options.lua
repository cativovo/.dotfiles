vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.statuscolumn = [[%!v:lua.require'cativovo.utils'.statuscolumn()]]
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.hlsearch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
-- prevent auto scroll to center when changing buffer using ctr^
vim.opt.jumpoptions = 'view'
vim.opt.winborder = 'single'
vim.opt.scrolloff = 4
