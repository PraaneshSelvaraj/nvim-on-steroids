-- Because why take responsibility when you can offload even your parentheses to a plugin?
return {
  'kylechui/nvim-surround',
  version = '^3.0.0',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {}
  end,
}
