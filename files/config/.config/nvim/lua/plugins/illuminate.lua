local next_keymap = "<C-Right>"
local prev_keymap = "<C-Left>"

return {
  "RRethy/vim-illuminate",
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    map(next_keymap, "next")
    map(prev_keymap, "prev")

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        map(next_keymap, "next", buffer)
        map(prev_keymap, "prev", buffer)
      end,
    })
  end,
  keys = {
    { next_keymap, desc = "Next Reference" },
    { prev_keymap, desc = "Prev Reference" },
  },
}
