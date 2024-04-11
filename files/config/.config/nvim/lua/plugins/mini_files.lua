local function copy_relative_path()
  vim.fn.setreg("+", vim.fn.fnamemodify(require("mini.files").get_fs_entry().path, ":."))
end

local function copy_absolute_path()
  vim.fn.setreg("+", require("mini.files").get_fs_entry().path)
end

local function copy_filename()
  vim.fn.setreg("+", require("mini.files").get_fs_entry().filename)
end

local function copy_extension()
  vim.fn.setreg("+", vim.fn.fnamemodify(require("mini.files").get_fs_entry().filename, ":e"))
end

return {
  "echasnovski/mini.files",
  opts = {
    options = {
      use_as_default_explorer = true,
    },
    mappings = {
      go_in = "L",
      go_in_plus = "l",
      go_out = "H",
      go_out_plus = "h",
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set("n", "Yr", copy_relative_path, { buffer = buf_id, desc = "Copy relative path" })
        vim.keymap.set("n", "Ya", copy_absolute_path, { buffer = buf_id, desc = "Copy absolute path" })
        vim.keymap.set("n", "Yf", copy_filename, { buffer = buf_id, desc = "Copy filename" })
        vim.keymap.set("n", "Ye", copy_extension, { buffer = buf_id, desc = "Copy extension" })
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        LazyVim.lsp.on_rename(event.data.from, event.data.to)
      end,
    })
  end,
}
