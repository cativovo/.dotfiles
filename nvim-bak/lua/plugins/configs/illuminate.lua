local M = {}

local function load_keymaps()
  local present, illuminate = pcall(require, 'illuminate')

  if not present then
    return
  end

  local keymaps = {
    n = {
      ["<C-Right>"] = { illuminate.goto_next_reference, "Go to next reference" },
      ["<C-Left>"] = { illuminate.goto_prev_reference, "Go to prev reference" },
    }
  }

  require("core.utils").load_keymaps(keymaps)
end

local function setup()
  local present, illuminate = pcall(require, "illuminate")

  if not present then
    return
  end

  -- default configuration
  illuminate.configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
      "dirvish",
      "fugitive",
      "alpha",
      "NvimTree",
      "packer",
      "neogitstatus",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- max_file_lines: max number of lines in a file to illuminate
    max_file_lines = nil,
  })
end

M.config = function()
  setup()
  -- set color
  -- use the same color of CursorLine highlight
  -- :hi to see all highlights
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "CursorLine" })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "CursorLine" })
  load_keymaps()
end

return M