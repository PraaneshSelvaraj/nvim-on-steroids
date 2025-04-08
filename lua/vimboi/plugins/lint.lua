return {
  -- Linting, because apparently we can't be trusted to write clean code on our own.
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' }, -- Triggered early, because obviously our code is broken from the moment it exists.
  config = function()
    local lint = require 'lint'

    -- 💡 Manually defining clang-tidy because clearly, life isn't hard enough.
    lint.linters.clangtidy = {
      cmd = 'clang-tidy', -- Assuming you installed this, because who doesn't love chasing dependencies?
      stdin = false,
      args = { '$FILENAME' },
      stream = 'stderr',
      ignore_exitcode = true,
      parser = require('lint.parser').from_errorformat [[
        %f:%l:%c: %trror: %m,
        %f:%l:%c: %tarning: %m,
        %f:%l:%c: %m
      ]],
    }

    -- Match filetypes to their judgemental friends.
    lint.linters_by_ft = {
      python = { 'pylint' },
      c = { 'clangtidy' },
      cpp = { 'clangtidy' },
      markdown = { 'markdownlint' }, -- For when your *bullet points* are more important than your code.
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        if vim.opt_local.modifiable:get() then
          lint.try_lint() -- Go ahead, point out my flaws, I dare you.
        end
      end,
    })
  end,
}
