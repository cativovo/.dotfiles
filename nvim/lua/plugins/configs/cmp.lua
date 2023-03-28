local M = {}

M.setup = function()
	local cmp = require("cmp")
	local cmp_types = require("cmp.types")
	local luasnip = require("luasnip")

	local kind_icons = {
		Array = " ",
		Boolean = " ",
		Class = " ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Copilot = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = " ",
		Interface = " ",
		Key = " ",
		Keyword = " ",
		Method = " ",
		Module = " ",
		Namespace = " ",
		Null = " ",
		Number = " ",
		Object = " ",
		Operator = " ",
		Package = " ",
		Property = " ",
		Reference = " ",
		Snippet = " ",
		String = " ",
		Struct = " ",
		Text = " ",
		TypeParameter = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
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
		nvim_lsp = 1,
		luasnip = 1,
	}

	local opts = {
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
			buffer = 1,
			path = 1,
			nvim_lsp = 1,
			luasnip = 1,
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
			{
				name = "nvim_lsp",
				entry_filter = function(entry)
					return cmp_types.lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
				end,
			},
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		},
		mapping = require("core.keymaps").cmp.get("setup", cmp),
	}

	cmp.setup(opts)
end

return M
