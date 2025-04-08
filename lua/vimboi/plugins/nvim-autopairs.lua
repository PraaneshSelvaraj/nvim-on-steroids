-- Because typing both brackets is apparently too much to ask
-- Thank you, autopairs, for enabling our laziness one keystroke at a time.
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
    disable_filetype = { 'TelescopePrompt', 'vim' },
  },
}

