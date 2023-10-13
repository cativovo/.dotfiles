return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  config = true,
  keys = {
    {
      "<leader>fa",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Add File to Harpoon",
    },
    {
      "<leader>fm",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon Menu",
    },
    {
      "<leader>fn",
      function()
        require("harpoon.ui").nav_next()
      end,
      desc = "Next File",
    },
    {
      "<leader>fp",
      function()
        require("harpoon.ui").nav_prev()
      end,
      desc = "Previous File",
    },
    {
      "<leader>fj",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "First File",
    },
    {
      "<leader>fk",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Second File",
    },
    {
      "<leader>fl",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Third File",
    },
    {
      "<leader>f;",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Fourth File",
    },
  },
}
