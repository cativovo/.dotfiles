local keymaps = {}

-- Builtin
keymaps.builtin = {
	normal = {
		-- Switch between windows
		["<C-h>"] = { "<C-w>h", "Window Left" },
		["<C-l>"] = { "<C-w>l", "Window Right" },
		["<C-j>"] = { "<C-w>j", "Window Down" },
		["<C-k>"] = { "<C-w>k", "Window Up" },
		-- Save
		["<C-s>"] = { ":w<cr>", "Save File" },
	},
	visual = {
		-- Move selected line / block of text in visual mode
		["K"] = { ":move '<-2<CR>gv-gv", "Move Line Up" },
		["J"] = { ":move '>+1<CR>gv-gv", "Move Line Down" },
		-- Copy text
		["<leader>y"] = { '"+y', "Copy To Clipboard" },
	},
}

-- Plugins
-- File explorer
keymaps.file_explorer = {
	normal = {
		e = {
			"<cmd>NvimTreeToggle<cr>",
			"Toggle File Explorer",
		},
	},
}

-- Git
keymaps.git = {
	normal = function(telescope_builtin)
		return {
			g = {
				name = "Git",
				s = { "<cmd>Git<cr>", "Source Control" },
				b = { "<cmd>Git blame<cr>", "Blame" },
				c = { telescope_builtin.git_commits, "Commits" },
				C = { telescope_builtin.git_bcommits, "Buffer Commits" },
				B = { telescope_builtin.git_branches, "Branches" },
				S = { telescope_builtin.git_stash, "Stash" },
			},
		}
	end,
	signs = {
		setup = function()
			local gs = package.loaded.gitsigns

			return {
				g = {
					n = {
						gs.next_hunk,
						"Next Hunk",
					},
					p = {
						gs.prev_hunk,
						"Previous Hunk",
					},
				},
			}
		end,
	},
	get = function(prop, source)
		return keymaps.git[prop](source)
	end,
}

-- Telescope
keymaps.telescope = {
	normal = function(telescope_builtin)
		return {
			["<C-p>"] = { telescope_builtin.find_files, "Find Files" },
			["<leader>t"] = {
				name = "Telescope",
				l = { telescope_builtin.live_grep, "Live Grep" },
				g = { telescope_builtin.grep_string, "Grep String" },
				j = { telescope_builtin.jumplist, "Show Jumplist" },
				s = { telescope_builtin.current_buffer_fuzzy_find, "Show Search History" },
				C = { telescope_builtin.commands, "Show Available Commands" },
				c = { telescope_builtin.command_history, "Show Command History" },
				m = { telescope_builtin.marks, "Show Marks" },
				r = { telescope_builtin.registers, "Show Registers" },
				S = { telescope_builtin.spell_suggest, "Show Spell Suggestions" },
			},
			["<leader>b"] = { telescope_builtin.buffers, "Show Buffers" },
		}
	end,
	setup = function(telescope_actions)
		return {
			i = {
				["<Tab>"] = telescope_actions.move_selection_next,
				["<S-Tab>"] = telescope_actions.move_selection_previous,
				["<Down>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_worse,
				["<Up>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_better,
			},
		}
	end,
	get = function(prop, source)
		return keymaps.telescope[prop](source)
	end,
}

-- Treesitter
keymaps.treesitter = {
	setup = {
		init_selection = "<C-Space>",
		node_incremental = "<C-Space>",
		scope_incremental = "grc",
		node_decremental = "<BS>",
	},
}

-- LSP
keymaps.lsp = {
	normal = function(telescope_builtin)
		return {
			["<leader>l"] = {
				name = "LSP",
				g = {
					name = "Go to",
					d = { telescope_builtin.lsp_definitions, "Definition" },
					t = { telescope_builtin.lsp_type_definitions, "Type Definition" },
					i = { telescope_builtin.lsp_implementations, "Implementation" },
					r = { telescope_builtin.lsp_references, "Reference" },
				},
				d = {
					function()
						telescope_builtin.diagnostics({ bufnr = 0, theme = "get_ivy" })
					end,
					"Buffer Diagnostics",
				},
				s = { telescope_builtin.lsp_document_symbols, "Document Symbols" },
				S = { telescope_builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols" },
				{
					a = { vim.lsp.buf.code_action, "Code Action" },
					-- for non mac os
					-- ["<A-p>"] = {
					-- utils.format_on_save,
					--   "Format"
					-- },
					--  ["π"] = {
					--    utils.format_on_save,
					--    "Format"
					--  },
					i = { ":LspInfo<CR>", "Info" },
					I = { ":Mason<CR>", "Mason Info" },
					r = { vim.lsp.buf.rename, "Rename" },
					l = {
						function()
							vim.diagnostic.open_float(0, { scope = "line" })
						end,
						"Show Current Line Diagnostic",
					},
				},
				t = {
					function()
						local config = require("core.config")
						config.autoformat = not config.autoformat
					end,
					"Toggle Autoformat",
				},
			},
			{
				K = { vim.lsp.buf.hover, "Show hover" },
				-- non macbook mappings
				-- ["<A-l>"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
				-- ["<A-h>"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
				-- ["<A-p>"] = { require("plugins.configs.lsp.format"), "Format" },
				-- macbook mappings
				["¬"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
				["˙"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
				["π"] = { require("plugins.configs.lsp.format"), "Format" },
			},
		}
	end,
	get = function(prop, source)
		return keymaps.lsp[prop](source)
	end,
}

-- Auto completion
keymaps.cmp = {
	setup = function(cmp)
		return {
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-3), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(3), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm(),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
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
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}
	end,
	get = function(prop, source)
		return keymaps.cmp[prop](source)
	end,
}

-- Snippet
keymaps.snippet = {
	insert = function(luasnip)
		return {
			-- macbook mappings
			["…"] = {
				opts = {
					mode = "s",
				},
				function()
					if luasnip.expand_or_jumpable() then
						luasnip.expand()
					end
				end,
				"Expand snippet",
			},
			["¬"] = {
				function()
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					end
				end,
				"Jump to next item",
			},
			["˙"] = {
				function()
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					end
				end,
				"Jump to previous item",
			},
			["∆"] = {
				function()
					if luasnip.choice_active() then
						luasnip.change_choice(1)
					end
				end,
				"Go to next choice",
			},
			["˚"] = {
				function()
					if luasnip.choice_active() then
						luasnip.change_choice(-1)
					end
				end,
				"Go to previous choice",
			},
			-- non macbook mappings
			-- ["<A-;>"] = {
			--   function()
			--     if ls.expand_or_jumpable() then
			--       ls.expand()
			--     end
			--   end,
			--   "Expand snippet"
			-- },
			-- ["<A-l>"] = {
			--   function()
			--     if ls.jumpable(1) then
			--       ls.jump(1)
			--     end
			--   end,
			--   "Jump to next item"
			-- },
			-- ["<A-h>"] = {
			--   function()
			--     if ls.jumpable(-1) then
			--       ls.jump(-1)
			--     end
			--   end,
			--   "Jump to previous item"
			-- },
			-- ["<A-j>"] = {
			--   function()
			--     if ls.choice_active() then
			--       ls.change_choice(1)
			--     end
			--   end,
			--   "Go to next choice"
			-- },
			-- ["<A-k>"] = {
			--   function()
			--     if ls.choice_active() then
			--       ls.change_choice(-1)
			--     end
			--   end,
			--   "Go to previous choice"
			-- },
		}
	end,
	get = function(prop, source)
		return keymaps.snippet[prop](source)
	end,
}

keymaps.comment = {
	setup = {
		comment = "",
		comment_line = "",
		textobject = "gc",
	},
}

keymaps.illuminate = {
	normal = function(illuminate)
		return {
			["<C-Right>"] = { illuminate.goto_next_reference, "Go to next reference" },
			["<C-Left>"] = { illuminate.goto_prev_reference, "Go to prev reference" },
		}
	end,
	get = function(prop, source)
		return keymaps.illuminate[prop](source)
	end,
}

return keymaps
