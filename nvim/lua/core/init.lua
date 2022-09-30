-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath "data" .. "/mason/bin"

require("plugins")
require("core.options")
require("core.settings")
require("core.utils").load_mappings()
require("core.autocmds").load()
