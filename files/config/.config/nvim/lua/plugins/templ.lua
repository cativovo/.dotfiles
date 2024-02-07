vim.filetype.add({ extension = { templ = "templ" } })

return {
  -- formatter config
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.templ = { "templ" }
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
}
