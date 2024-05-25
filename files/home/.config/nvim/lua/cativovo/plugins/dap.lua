---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' ')) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], ' ')
  end
  return config
end

local key_desc_prefix = 'DAP: '

local function enrich_config(finalConfig, on_config)
  local final_config = vim.deepcopy(finalConfig)

  -- https://github.com/mfussenegger/nvim-dap/discussions/548#discussioncomment-8778225
  -- Placeholder expansion for launch directives
  local placeholders = {
    ['${file}'] = function(_)
      return vim.fn.expand('%:p')
    end,
    ['${fileBasename}'] = function(_)
      return vim.fn.expand('%:t')
    end,
    ['${fileBasenameNoExtension}'] = function(_)
      return vim.fn.fnamemodify(vim.fn.expand('%:t'), ':r')
    end,
    ['${fileDirname}'] = function(_)
      return vim.fn.expand('%:p:h')
    end,
    ['${fileExtname}'] = function(_)
      return vim.fn.expand('%:e')
    end,
    ['${relativeFile}'] = function(_)
      return vim.fn.expand('%:.')
    end,
    ['${relativeFileDirname}'] = function(_)
      return vim.fn.fnamemodify(vim.fn.expand('%:.:h'), ':r')
    end,
    ['${workspaceFolder}'] = function(_)
      return vim.fn.getcwd()
    end,
    ['${workspaceFolderBasename}'] = function(_)
      return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end,
    ['${env:([%w_]+)}'] = function(match)
      return os.getenv(match) or ''
    end,
  }

  local filepath = nil

  if final_config.envFile then
    filepath = final_config.envFile
    for key, fn in pairs(placeholders) do
      filepath = filepath:gsub(key, fn)
    end
  elseif vim.fn.filereadable('.env.debug') == 1 then
    filepath = '.env.debug'
  end

  if filepath ~= nil then
    for line in io.lines(filepath) do
      local words = {}
      for word in string.gmatch(line, '[^=]+') do
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

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = key_desc_prefix .. "UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = key_desc_prefix .. "eval", mode = {"n", "v"} },
        { "<leader>td",  '<cmd>DapVirtualTextToggle<cr>', desc = key_desc_prefix .. "toggle inlay hints" },
      },
      config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        ---@diagnostic disable-next-line: missing-fields
        dapui.setup({
          layouts = {
            {
              elements = {
                {
                  id = 'breakpoints',
                  size = 0.25,
                },
                {
                  id = 'stacks',
                  size = 0.50,
                },
                {
                  id = 'watches',
                  size = 0.25,
                },
              },
              position = 'left',
              size = 40,
            },
            {
              elements = {
                {
                  id = 'scopes',
                  size = 0.5,
                },
                {
                  id = 'repl',
                  size = 0.5,
                },
              },
              position = 'bottom',
              size = 10,
            },
          },
        })

        dap.listeners.after.event_initialized.dapui_config = function()
          dapui.open({})
        end
        -- dap.listeners.before.event_terminated.dapui_config = function()
        --   vim.keymap.del('n', '<leader>td')
        -- end
      end,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        clear_on_continue = true,
      },
    },
  },
  -- stylua: ignore
  keys = function ()
		local dap = require("dap")
  	return {
    { "<leader>dO", dap.step_out, desc = key_desc_prefix .. "step out" },
    { "<leader>do", dap.step_over, desc = key_desc_prefix .. "step over" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = key_desc_prefix .. "breakpoint condition" },
    { "<leader>db", dap.toggle_breakpoint, desc = key_desc_prefix .. "toggle breakpoint" },
    { "<leader>dc", dap.continue, desc = key_desc_prefix .. "continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = key_desc_prefix .. "run with args" },
    { "<leader>dC", dap.run_to_cursor, desc = key_desc_prefix .. "run to cursor" },
    { "<leader>dg", dap.goto_, desc = key_desc_prefix .. "go to line (no execute)" },
    { "<leader>di", dap.step_into, desc = key_desc_prefix .. "step into" },
    { "<leader>dj", dap.down, desc = key_desc_prefix .. "down" },
    { "<leader>dk", dap.up, desc = key_desc_prefix .. "up" },
    { "<leader>dL", dap.run_last, desc = key_desc_prefix .. "run last" },
    { "<leader>dp", dap.pause, desc = key_desc_prefix .. "pause" },
    { "<leader>dS", dap.session, desc = key_desc_prefix .. "session" },
    { "<leader>dt", dap.terminate, desc = key_desc_prefix .. "terminate" },
    { "<leader>dw", dap.hover, desc = key_desc_prefix .. "widgets" },
  }
  end,

  config = function()
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

    local icons = require('cativovo.config.icons').dap
    for name, sign in pairs(icons) do
      sign = type(sign) == 'table' and sign or { sign }
      vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
    end

    -- setup dap config by VsCode launch.json file
    if vim.fn.filereadable('launch.json') == 1 then
      require('dap.ext.vscode').load_launchjs('launch.json')
    else
      require('dap.ext.vscode').load_launchjs()
    end

    local dap = require('dap')
    for key, config in pairs(dap.adapters) do
      if type(config) == 'table' then
        dap.adapters[key] = vim.tbl_deep_extend('force', config, {
          enrich_config = enrich_config,
        })
      end
    end
  end,
}
