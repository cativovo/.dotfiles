vim.filetype.add({ extension = { templ = "templ" } })

return {
  -- formatter config
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- run order: rustywind -> templ
      opts.formatters_by_ft.templ = { "rustywind", "templ" }
    end,
  },
  -- lsp config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "templ" },
        },
        htmx = {
          filetypes = { "html", "templ" },
        },
        emmet_language_server = {
          filetypes = {
            "css",
            "html",
            "javascript",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "typescriptreact",
            "templ",
          },
        },
        tailwindcss = {
          filetypes = { "templ", "javascript", "typescript", "react" },
          init_options = { userLanguages = { templ = "html" } },
        },
      },
    },
  },
  -- mason config
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "rustywind", "templ", "html-lsp", "htmx-lsp" })
    end,
  },
  -- treesitter config
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "templ",
      })
    end,
  },
}
