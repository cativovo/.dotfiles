local M = {}

M.general = {
  n = {
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window Left" },
    ["<C-l>"] = { "<C-w>l", "Window Right" },
    ["<C-j>"] = { "<C-w>j", "Window Down" },
    ["<C-k>"] = { "<C-w>k", "Window Up" },

    -- save
    ["<C-s>"] = { ":w<CR>", "Save File" },
  },
  v = {
    -- Move selected line / block of text in visual mode
    ["K"] = { ":move '<-2<CR>gv-gv", "Move Line up" },
    ["J"] = { ":move '>+1<CR>gv-gv", "Move Line down" },
  }
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>e"] = { ":NvimTreeToggle<CR>", "Toggle Nvimtree" }
  }
}

M.telescope = {
  plugin = true,

  n = {
    -- open file finder
    ["<C-p>"] = { ":lua require('telescope.builtin').find_files()<CR>", "Find Files" },
    ["<leader>tl"] = { ":lua require('telescope.builtin').live_grep()<CR>", "Live Grep" },
    ["<leader>tg"] = { ":lua require('telescope.builtin').grep_string()<CR>", "Grep String" },
    ["<leader>tj"] = { ":lua require('telescope.builtin').jumplist()<CR>", "Show Jumplist" },
    ["<leader>ts"] = { ":lua require('telescope.builtin').search_history()<CR>", "Show Search History" },
  }
}

M.lspconfig = {
  n = {
    -- go to
    ["<leader>lgd"] = { ":lua require('telescope.builtin').lsp_definitions()<CR>", "Definition" },
    ["<leader>lgt"] = { ":lua require('telescope.builtin').lsp_type_definitions()<CR>", "Type Definition" },
    ["<leader>lgi"] = { ":lua require('telescope.builtin').lsp_implementations()<CR>", "Implementation" },
    ["<leader>lgr"] = { ":lua require('telescope.builtin').lsp_references()<CR>", "Reference" },

    ["<leader>la"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    ["<leader>ld"] = { ":Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer Diagnostics" },
    -- TODO add formatting
    -- ["<leader>lf"] = { require("lvim.lsp.utils").format, "Format" },
    ["<leader>li"] = { ":LspInfo<CR>", "Info" },
    ["<leader>lI"] = { ":Mason<CR>", "Mason Info" },
    ["<leader>ls"] = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" },
    ["<leader>lS"] = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
    ["<leader>le"] = { ":Telescope quickfix<CR>", "Telescope Quickfix" },
    ["<leader>lr"] = { vim.lsp.buf.rename, "Rename" },
    ["<leader>lq"] = { vim.diagnostic.setloclist, "Quickfix" },
    ["K"] = { vim.lsp.buf.hover, "Show hover" },

    -- diagnostics
    ["<leader>lj"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
    ["<leader>lk"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
    ["<leader>ll"] = { ':lua vim.diagnostic.open_float(0, { scope = "line" })<CR>', "Show Current Line Diagnostic" },
    ["<leader>lw"] = { ":Telescope diagnostics<CR>", "Diagnostics" },
  }
}

return M
