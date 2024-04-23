return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
      end,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
  },

  config = function()
    local Config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- setup dap config by VsCode launch.json file
    require("dap.ext.vscode").load_launchjs()
    local enrich_config = function(finalConfig, on_config)
      local final_config = vim.deepcopy(finalConfig)

      -- https://github.com/mfussenegger/nvim-dap/discussions/548#discussioncomment-8778225
      -- Placeholder expansion for launch directives
      local placeholders = {
        ["${file}"] = function(_)
          return vim.fn.expand("%:p")
        end,
        ["${fileBasename}"] = function(_)
          return vim.fn.expand("%:t")
        end,
        ["${fileBasenameNoExtension}"] = function(_)
          return vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r")
        end,
        ["${fileDirname}"] = function(_)
          return vim.fn.expand("%:p:h")
        end,
        ["${fileExtname}"] = function(_)
          return vim.fn.expand("%:e")
        end,
        ["${relativeFile}"] = function(_)
          return vim.fn.expand("%:.")
        end,
        ["${relativeFileDirname}"] = function(_)
          return vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r")
        end,
        ["${workspaceFolder}"] = function(_)
          return vim.fn.getcwd()
        end,
        ["${workspaceFolderBasename}"] = function(_)
          return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        ["${env:([%w_]+)}"] = function(match)
          return os.getenv(match) or ""
        end,
      }

      if final_config.envFile then
        local filePath = final_config.envFile
        for key, fn in pairs(placeholders) do
          filePath = filePath:gsub(key, fn)
        end

        for line in io.lines(filePath) do
          local words = {}
          for word in string.gmatch(line, "[^=]+") do
            table.insert(words, word)
          end
          if not final_config.env then
            final_config.env = {}
          end
          final_config.env[words[1]] = words[2]
        end
      end

      on_config(final_config)
    end

    local dap = require("dap")
    for key, config in pairs(dap.adapters) do
      if type(config) == "table" then
        dap.adapters[key] = vim.tbl_deep_extend("force", config, {
          enrich_config = enrich_config,
        })
      end
    end
  end,
}
