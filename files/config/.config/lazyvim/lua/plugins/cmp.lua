return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    local bordered = require("cmp.config.window").bordered

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
    })

    opts.formatting = vim.tbl_extend("force", opts.formatting, {
      format = function(_, item)
        local icons = require("lazyvim.config").icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end

        local max_text_length = 27

        if #item.abbr > max_text_length then
          item.abbr = string.sub(item.abbr, 1, max_text_length - 1) .. "…"
        end

        if item.menu ~= nil then
          item.menu = nil
        end

        return item
      end,
    })

    opts.window = vim.tbl_extend("force", opts.window or {}, {
      completion = bordered(),
      documentation = bordered(),
    })
  end,
}
