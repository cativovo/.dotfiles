local M = {}

local function load_keymaps(luasnip)
  require("which-key").register(require("core.keymaps").snippet.get("insert", luasnip), { mode = "i" })
end

local types = require("luasnip.util.types")
local opts = {
  history = true,                            --keep around last snippet local to jump back
  updateevents = "TextChanged,TextChangedI", --update changes as you type
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } },
      },
    },
  },
}

M.setup = function()
  local luasnip = require("luasnip")
  local lua_loader = require("luasnip.loaders.from_lua")

  lua_loader.load({ paths = "~/.config/nvim/snippets/" })
  luasnip.config.set_config(opts)

  load_keymaps(luasnip)
end

return M
