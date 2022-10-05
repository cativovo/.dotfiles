-- general mappings
-- plugin mappings(except for lsp) are inside of their config
-- example: plugins/configs/telescope.lua
local utils = require("core.utils")

return {
  n = {
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window Left" },
    ["<C-l>"] = { "<C-w>l", "Window Right" },
    ["<C-j>"] = { "<C-w>j", "Window Down" },
    ["<C-k>"] = { "<C-w>k", "Window Up" },

    -- save
    ["<C-s>"] = { ":w<CR>", "Save File" },

    -- settings
    ["<leader>Sf"] = { utils.toggle_format_on_save, "Toggle Format On Save" }
  },
  v = {
    -- Move selected line / block of text in visual mode
    ["K"] = { ":move '<-2<CR>gv-gv", "Move Line Up" },
    ["J"] = { ":move '>+1<CR>gv-gv", "Move Line Down" },
    ["<leader>y"] = { '"+y', "Copy To Clipboard" },
  }
}
