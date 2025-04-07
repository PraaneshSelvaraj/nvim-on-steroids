-- Vimboi Autocommands: Because I like my editor to react more than I do

-- Highlight on yank because I need *visual reassurance* I did something
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Flashy highlight when I yoink some text',
  group = vim.api.nvim_create_augroup('vimboi-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
