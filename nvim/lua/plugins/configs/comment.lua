local M = {}

local function load_keys()
  local keymaps = {
    n = {
      [""] = {
        function()
          return vim.v.count == 0
              and '<Plug>(comment_toggle_linewise_current)'
              or '<Plug>(comment_toggle_linewise_count)'
        end,
        "Toggle Nvimtree",
        opts = {
          expr = true
        }
      }
    },
    v = {
      [""] = {
        "<Plug>(comment_toggle_linewise_visual)",
        "Toggle Nvimtree",
      }
    }
  }

  require("core.utils").load_keymaps(keymaps)
end

-- https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/comment.lua
local function pre_hook(ctx)
  local present, comment_utils = pcall(require, "Comment.utils")

  if not present then
    return
  end
  -- Determine whether to use linewise or blockwise commentstring
  local type = ctx.ctype == comment_utils.ctype.linewise and "__default" or "__multiline"

  -- Determine the location where to calculate commentstring from
  local location = nil
  if ctx.ctype == comment_utils.ctype.blockwise then
    location = require("ts_context_commentstring.utils").get_cursor_location()
  elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
    location = require("ts_context_commentstring.utils").get_visual_start_location()
  end

  return require("ts_context_commentstring.internal").calculate_commentstring {
    key = type,
    location = location,
  }
end

local function setup()
  local present, comment = pcall(require, "Comment")

  if not present then
    return
  end

  local options = {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = nil,
      ---Block-comment toggle keymap
      block = nil,
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = nil,
      ---Block-comment keymap
      block = nil,
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = nil,
      ---Add comment on the line below
      below = nil,
      ---Add comment at the end of line
      eol = nil,
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = false,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = false,
      ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
      extended = false,
    },
    ---Function to call before (un)comment
    pre_hook = pre_hook,
    ---Function to call after (un)comment
    post_hook = nil,
  }

  comment.setup(options)

end

M.config = function()
  setup()
  load_keys()
end

return M
