-- Because you totally need Git integration... right? Like, you're *always* committing perfect code.
return {
  'tpope/vim-fugitive',
  lazy = false,
  keys = {
    { '<leader>gs', '<cmd>Git<CR>', desc = 'Open Git status' },
  },
}
