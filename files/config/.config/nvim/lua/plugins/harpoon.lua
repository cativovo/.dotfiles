return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  config = function(_, opts)
    require("harpoon"):setup(opts)
  end,
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
    {
      "<leader>fa",
      function()
        require("harpoon"):list():append()
      end,
      desc = "Add File to Harpoon",
    },
    {
      "<leader>fm",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon Menu",
    },
    {
      "<leader>fj",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "First File",
    },
    {
      "<leader>fk",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Second File",
    },
    {
      "<leader>fl",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Third File",
    },
    {
      "<leader>f;",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Fourth File",
    },
  },
}
