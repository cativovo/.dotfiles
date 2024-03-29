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
		["<leader>"] = {
			-- quickfix list
			q = {
				o = { ":copen<cr>", "Open Quickfix list" },
				c = { ":cclose<cr>", "Close Quickfix list" },
				j = { ":cnext<cr>", "Next Item" },
				k = { ":cprev<cr>", "Prev Item" },
				d = { require("core.utils.quickfix_list").RemoveQuickfixItemByCursor, "Remove Item" },
				"QuickFix List",
			},
		},
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
	normal = {
		g = {
			name = "Git",
			s = { "<cmd>Telescope git_status<cr>", "Status" },
			f = { "<cmd>Git<cr>", "Fugitive" },
			b = { "<cmd>Git blame<cr>", "Blame" },
			c = { "<cmd>Telescope git_commits<cr>", "Commits" },
			C = { "<cmd>Telescope git_bcommits<cr>", "Buffer Commits" },
			B = { "<cmd>Telescope git_branches<cr>", "Branches" },
			S = { "<cmd>Telescope git_stash<cr>", "Stash" },
		},
	},
	visual = {
		["<leader>g"] = {
			"Git",
			h = {
				"Hunk",
				s = {
					function()
						package.loaded.gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					"Stage Hunk",
				},
				r = {
					function()
						package.loaded.gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					"Reset Hunk",
				},
			},
		},
	},
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
					h = {
						"Hunk",
						s = {
							gs.stage_hunk,
							"Stage hunk",
						},
						S = {
							gs.select_hunk,
							"Select hunk",
						},
						u = {
							gs.undo_stage_hunk,
							"Stage hunk",
						},
						p = {
							gs.preview_hunk,
							"Preview hunk",
						},
						r = {
							gs.reset_hunk,
							"Reset hunk",
						},
					},
				},
			}
		end,
	},
}

-- Telescope
keymaps.telescope = {
	normal = {
		["<C-p>"] = { "<cmd>Telescope find_files hidden=true<cr>", "Find Files" },
		["<leader>t"] = {
			name = "Telescope",
			l = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
			L = { "<cmd>Telescope live_grep_args live_grep_args<cr>", "Live Grep With Args" },
			g = { "<cmd>Telescope grep_string<cr>", "Grep String" },
			j = { "<cmd>Telescope jumplist<cr>", "Show Jumplist" },
			s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Show Search History" },
			C = { "<cmd>Telescope commands<cr>", "Show Available Commands" },
			c = { "<cmd>Telescope command_history<cr>", "Show Command History" },
			m = { "<cmd>Telescope marks<cr>", "Show Marks" },
			r = { "<cmd>Telescope registers<cr>", "Show Registers" },
			S = { "<cmd>Telescope spell_suggest<cr>", "Show Spell Suggestions" },
			u = { "<cmd>Telescope undo<cr>", "Show Undo History" },
		},
		["<leader>b"] = { "<cmd>Telescope buffers<cr>", "Show Buffers" },
	},
	setup = function(telescope_actions)
		return {
			default = {
				i = {
					["<Tab>"] = telescope_actions.move_selection_next,
					["<S-Tab>"] = telescope_actions.move_selection_previous,
					["<Down>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_worse,
					["<Up>"] = telescope_actions.toggle_selection + telescope_actions.move_selection_better,
				},
			},
			pickers = {
				git_status = {
					i = {
						["<Tab>"] = telescope_actions.move_selection_next,
						["<S-Tab>"] = telescope_actions.move_selection_previous,
					},
				},
			},
		}
	end,
	undo_setup = function(telescope_undo_actions)
		local maps = {
			-- ["<C-cr>"] = telescope_undo_actions.yank_additions,
			-- ["<S-cr>"] = telescope_undo_actions.yank_deletions,
			["<cr>"] = telescope_undo_actions.restore,
		}

		return {
			i = maps,
			n = maps,
		}
	end,
	live_grep_args_setup = function(lga_actions)
		return { -- extend mappings
			i = {
				["<C-k>"] = lga_actions.quote_prompt(),
				["<C-j>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
			},
		}
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
	normal = {
		["<leader>l"] = {
			name = "LSP",
			g = {
				name = "Go to",
				d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
				t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definition" },
				i = { "<cmd>Telescope lsp_implementations<cr>", "Implementation" },
				r = { "<cmd>Telescope lsp_references<cr>", "Reference" },
			},
			d = {
				function()
					require("telescope.builtin").diagnostics({ bufnr = 0, theme = "get_ivy" })
				end,
				"Buffer Diagnostics",
			},
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
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
	},
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
}

-- Neorg
keymaps.neorg = {
	normal = {
		n = {
			name = "Neorg",
			w = {
				require("core.utils.telescope_custom_pickers").neorg.open_workspace,
				"Workspaces",
			},
			o = { ":Neorg index<cr>", "Open Index" },
		},
	},
	autocmd = {
		n = {
			x = {
				name = "Export",
				f = {
					":Neorg export to-file ",
					"To file",
					silent = false,
				},
				d = {
					":Neorg export directory ",
					"Directory",
					silent = false,
				},
				buffer = 0,
			},
			e = {
				":NvimTreeToggle" .. require("plugins.configs.neorg").base_directory .. "<cr>",
				"Explorer",
				buffer = 0,
			},
			q = {
				":Neorg return<cr>",
				"Quit",
				buffer = 0,
			},
			f = {
				function()
					require("telescope.builtin").find_files({
						cwd = require("neorg").modules.get_module("core.dirman").get_current_workspace()[2],
					})
				end,
				"Find Note",
				buffer = 0,
			},
			l = {
				function()
					require("telescope.builtin").live_grep({
						cwd = require("neorg").modules.get_module("core.dirman").get_current_workspace()[2],
					})
				end,
				"Live Grep Notes",
				buffer = 0,
			},
		},
	},
}

-- Harpoon
keymaps.harpoon = {
	h = {
		"Harpoon",
		a = {
			function()
				require("harpoon.mark").add_file()
			end,
			"Add File",
		},
		m = {
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			"Menu",
		},
		n = {
			function()
				require("harpoon.ui").nav_next()
			end,
			"Next File",
		},
		p = {
			function()
				require("harpoon.ui").nav_prev()
			end,
			"Previous File",
		},
		j = {
			function()
				require("harpoon.ui").nav_file(1)
			end,
			"First File",
		},
		k = {
			function()
				require("harpoon.ui").nav_file(2)
			end,
			"Second File",
		},
		l = {
			function()
				require("harpoon.ui").nav_file(3)
			end,
			"Third File",
		},
		[";"] = {
			function()
				require("harpoon.ui").nav_file(4)
			end,
			"Fourth File",
		},
	},
}

-- Flash
keymaps.flash = {
	setup = function(flash)
		return {
			s = {
				mode = { "n", "x", "o" },
				function()
					flash.jump()
				end,
				"Flash Jump",
			},
			S = {
				mode = { "n", "o", "x" },
				function()
					flash.treesitter()
				end,
				"Flash Treesitter",
			},
			["<c-s>"] = {
				mode = { "c" },
				function()
					flash.toggle()
				end,
				"Toggle Flash Search",
			},
			r = {
				mode = "o",
				function()
					flash.remote()
				end,
				"Remote Flash",
			},
			R = {
				mode = { "o", "x" },
				function()
					flash.treesitter_search()
				end,
				"Treesitter Search",
			},
		}
	end,
}

-- Language Specific keymaps
keymaps.rust = {
	normal = {
		["<leader>r"] = {
			name = "Rust",
			r = { "<cmd>RustRun<cr>", "Run" },
		},
	},
}

-- Language Specific keymaps
keymaps.typescript = {
	normal = {
		["<leader>l"] = {
			o = { "<cmd>OrganizeImports<cr>", "Organize Imports" },
		},
	},
}

return keymaps
