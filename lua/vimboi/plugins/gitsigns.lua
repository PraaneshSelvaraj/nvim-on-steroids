-- Because knowing what you broke is half the battle
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add          = { text = '+' },   -- green means go... until it doesn’t
      change       = { text = '~' },   -- gentle reminder you touched stuff
      delete       = { text = '_' },   -- vanished like my motivation
      topdelete    = { text = '‾' },   -- poetic floating delete
      changedelete = { text = '~' },   -- touched then trashed
    },
    -- You can slap more options here if you’re feeling adventurous
  },
}

