local function copy_to_clipboard(contents)
  vim.fn.setreg("+", contents)
end

local function copy_relative_path()
  copy_to_clipboard(vim.fn.fnamemodify(require("mini.files").get_fs_entry().path, ":."))
end

local function copy_absolute_path()
  copy_to_clipboard(require("mini.files").get_fs_entry().path)
end

local function copy_filename()
  copy_to_clipboard(require("mini.files").get_fs_entry().name)
end

local function copy_extension()
  copy_to_clipboard(vim.fn.fnamemodify(require("mini.files").get_fs_entry().name, ":e"))
end

local function open_in_split(direction)
  return function()
    local is_file = require("mini.files").get_fs_entry().fs_type == "file"
    if not is_file then
      return
    end

    local new_target_window
    vim.api.nvim_win_call(require("mini.files").get_target_window(), function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)

    require("mini.files").set_target_window(new_target_window)
    require("mini.files").go_in({ close_on_file = true })
  end
end

local function toggle_open(path, use_latest)
  if not require("mini.files").close() then
    require("mini.files").open(path, use_latest)
  end
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
        toggle_open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
    {
      "<leader>E",
      function()
        toggle_open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        require("which-key").register({
          ["<cr>"] = {
            function()
              require("mini.files").go_in({ close_on_file = true })
            end,
            "Open file",
          },
          ["<leader>y"] = {
            name = "copy",
            r = { copy_relative_path, "Copy relative path" },
            a = { copy_absolute_path, "Copy absolute path" },
            f = { copy_filename, "Copy filename" },
            e = { copy_extension, "Copy extension" },
          },
          ["<C-v>"] = { open_in_split("vertical"), "Split right" },
          ["<C-x>"] = { open_in_split("horizontal"), "Split above" },
        }, { buffer = args.data.buf_id })
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
