-- https://github.com/LazyVim/LazyVim/discussions/275#discussioncomment-7457295
return {
  {
    "mfussenegger/nvim-jdtls",
    ---@type lspconfig.options.jdtls
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      jdtls = function(opts)
        local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
        local jvmArg = "-javaagent:" .. install_path .. "/lombok.jar"
        table.insert(opts.cmd, "--jvm-arg=" .. jvmArg)
        return opts
      end,
    },
  },
}
