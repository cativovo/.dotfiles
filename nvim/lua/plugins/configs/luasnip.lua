local M = {}

local function load_keymaps()
  local present, ls = pcall(require, 'luasnip')

  if not present then
    return
  end

  local keymaps = {
    ['i,s'] = {
      -- macbook mappings
      ["…"] = {
        opts = {
          mode = "s"
        },
        function()
          if ls.expand_or_jumpable() then
            ls.expand()
          end
        end,
        "Expand snippet"
      },
      ["¬"] = {
        function()
          if ls.jumpable(1) then
            ls.jump(1)
          end
        end,
        "Jump to next item"
      },
      ["˙"] = {
        function()
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end,
        "Jump to previous item"
      },
      ["∆"] = {
        function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        "Go to next choice"
      },
      ["˚"] = {
        function()
          if ls.choice_active() then
            ls.change_choice(-1)
          end
        end,
        "Go to previous choice"
      },
      -- non macbook mappings
      -- ["<A-;>"] = {
      --   function()
      --     if ls.expand_or_jumpable() then
      --       ls.expand()
      --     end
      --   end,
      --   "Expand snippet"
      -- },
      -- ["<A-l>"] = {
      --   function()
      --     if ls.jumpable(1) then
      --       ls.jump(1)
      --     end
      --   end,
      --   "Jump to next item"
      -- },
      -- ["<A-h>"] = {
      --   function()
      --     if ls.jumpable(-1) then
      --       ls.jump(-1)
      --     end
      --   end,
      --   "Jump to previous item"
      -- },
      -- ["<A-j>"] = {
      --   function()
      --     if ls.choice_active() then
      --       ls.change_choice(1)
      --     end
      --   end,
      --   "Go to next choice"
      -- },
      -- ["<A-k>"] = {
      --   function()
      --     if ls.choice_active() then
      --       ls.change_choice(-1)
      --     end
      --   end,
      --   "Go to previous choice"
      -- },
    }
  }

  require("core.utils").load_keymaps(keymaps)
end

local function setup()
  local luasnip_present, luasnip = pcall(require, "luasnip")
  local lua_loader_present, lua_loader = pcall(require, "luasnip.loaders.from_lua")
  local types_present, types = pcall(require, "luasnip.util.types")

  if not luasnip_present or not lua_loader_present or not types_present then
    return
  end

  load_keymaps()

  local opts = {
    history = true, --keep around last snippet local to jump back
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

  lua_loader.load({ paths = "~/.config/nvim/snippets/" })
  luasnip.config.set_config(opts)
end

M.config = function()
  setup()
  load_keymaps()
end

return M
