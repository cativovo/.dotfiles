return {
  "folke/noice.nvim",
  keys = {
    -- DISABLED
    { "<c-f>", false },
    { "<c-b>", false },
    -- MY KEYS
    {
      "<C-d>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<c-d>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll Down",
      mode = { "i", "n", "s" },
    },
    {
      "<C-u>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-u>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll Up",
      mode = { "i", "n", "s" },
    },
  },
  opts = {
    cmdline = {
      view = "cmdline",
      format = {
        cmdline = false,
        search_down = false,
        search_up = false,
        filter = false,
        lua = false,
        help = false,
      },
    },
    popupmenu = {
      enabled = false,
    },
  },
}
