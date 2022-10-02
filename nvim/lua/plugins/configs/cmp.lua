local M = {}

local function setup()
  local cmp_present, cmp = pcall(require, "cmp")
  local luasnip_present, luasnip = pcall(require, "luasnip")

  if not cmp_present or not luasnip_present then
    return
  end

  -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
  local kind_icons = {
    Text = "  ",
    Method = "  ",
    Function = "  ",
    Constructor = "  ",
    Field = "  ",
    Variable = "  ",
    Class = "  ",
    Interface = "  ",
    Module = "  ",
    Property = "  ",
    Unit = "  ",
    Value = "  ",
    Enum = "  ",
    Keyword = "  ",
    Snippet = "  ",
    Color = "  ",
    File = "  ",
    Reference = "  ",
    Folder = "  ",
    EnumMember = "  ",
    Constant = "  ",
    Struct = "  ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
  }

  local source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    tmux = "(TMUX)",
  }

  local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
  }

  local options = {
    preselect = cmp.PreselectMode.None,
    formatting = {
      format = function(entry, vim_item)
        -- menu item max text length
        local max_text_length = 27
        local duplicates_default = 0

        if max_text_length ~= 0 and #vim_item.abbr > max_text_length then
          -- menu item text
          vim_item.abbr = string.sub(vim_item.abbr, 1, max_text_length - 1) .. "…"
        end

        vim_item.kind = kind_icons[vim_item.kind] or ""
        vim_item.menu = source_names[entry.source.name]
        vim_item.dup = duplicates[entry.source.name] or duplicates_default

        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
    },
    experimental = {
      ghost_text = false,
      native_menu = false,
    },
    completion = {
      keyword_length = 1,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
    mapping = {
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
  }

  cmp.setup(options)
end

M.config = function()
  setup()
end

return M
