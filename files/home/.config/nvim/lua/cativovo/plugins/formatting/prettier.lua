return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'prettier')
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local formatters_by_ft = {
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        less = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        ['markdown.mdx'] = { 'prettier' },
        graphql = { 'prettier' },
        handlebars = { 'prettier' },
      }

      for ft, formatters in pairs(formatters_by_ft) do
        if opts.formatters_by_ft[ft] == nil then
          opts.formatters_by_ft[ft] = formatters
        else
          vim.list_extend(opts.formatters_by_ft[ft], formatters)
        end
      end
    end,
  },
}
