-- Vimboi Autocommands: Because I like my editor to react more than I do

-- Highlight on yank because I need *visual reassurance* I did something
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Flashy highlight when I yoink some text',
  group = vim.api.nvim_create_augroup('vimboi-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-install treesitter parsers when opening a file
-- Because manually installing parsers is so last decade
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Auto-install treesitter parser for filetype',
  group = vim.api.nvim_create_augroup('vimboi-treesitter-auto-install', { clear = true }),
  callback = function(args)
    local filetype = args.match

    -- Check if treesitter is available
    local ok_parsers, parsers = pcall(require, 'nvim-treesitter.parsers')
    if not ok_parsers then
      return
    end

    -- Check if parser exists for this filetype and is not installed
    local parser_config = parsers.get_parser_configs()[filetype]
    if parser_config and not parsers.has_parser(filetype) then
      vim.notify('Installing treesitter parser for ' .. filetype .. '...', vim.log.levels.INFO)
      vim.cmd('TSInstall ' .. filetype)
    end
  end,
})
