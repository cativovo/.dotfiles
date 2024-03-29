local options = {
	completeopt = "menuone,noinsert,noselect",
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
	smartindent = false,
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
	scrolloff = 2,
	timeoutlen = 500,
	conceallevel = 0,
	fileencoding = "utf-8",
	foldmethod = "manual",
	foldexpr = "",
	showmode = false,
	title = true,
	numberwidth = 4,
	ruler = false,
	laststatus = 3,
	shortmess = vim.opt.shortmess + "c" + "I",
	mouse = "", -- disable mouse
}

for key, value in pairs(options) do
	vim.opt[key] = value
end
-- set leader key
vim.g.mapleader = " "
