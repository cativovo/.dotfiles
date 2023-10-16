return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    local bordered = require("cmp.config.window").bordered

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
    })
    opts.window = vim.tbl_extend("force", opts.window or {}, {
      completion = bordered(),
      documentation = bordered(),
    })
  end,
}
