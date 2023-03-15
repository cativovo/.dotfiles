local M = {}

M.setup = function()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    return
  end

  local options = {
    sources = {
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.completion.spell,

      -- formatters
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
      -- use eslint_d formatter if there's eslint file config
      null_ls.builtins.formatting.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file({
            ".eslintrc.cjs",
            ".eslintrc.js",
            ".eslintrc.json",
            ".eslintrc.yaml",
            ".eslintrc.yml",
            ".eslintrc"
          })
        end,
      }),
    },
  }

  null_ls.setup(options)
end

return M
