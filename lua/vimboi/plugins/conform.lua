return {
  -- Autoformat because, clearly, your code is so messy, it needs someone to fix it for you.
  -- But hey, don't worry, this plugin will do the hard work of cleaning up after you.
  'stevearc/conform.nvim',

  event = { 'BufWritePre' }, -- Automatically format before you even think about saving. Because you clearly need this.
  cmd = { 'ConformInfo' },

  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },

  opts = {
    notify_on_error = false,

    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,

    formatters_by_ft = {
      lua = { 'stylua' },
    },
  },
}
