local autoformat = true

return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>tf',
      function()
        autoformat = not autoformat
        local label = 'off'
        if autoformat then
          label = 'on'
        end
        vim.notify('autoformat: ' .. label)
      end,
      desc = 'toggle autoformat',
    },
    {
      '<leader>fb',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = 'format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if not autoformat then
        return
      end

      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = {}
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
  },
}
