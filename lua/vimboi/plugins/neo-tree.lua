-- neo-tree.lua — file navigation for people who forgot where they put their code
-- because apparently typing :e and tab-completing like a caveman wasn't cutting it anymore

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- pretty icons so you feel professional while breaking prod
    'MunifTanjim/nui.nvim', -- UI library because raw vim UI would make you cry harder
    -- "3rd/image.nvim", -- Optional image support. Because looking at images in a terminal editor makes total sense.
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle Neo-tree' }, -- loads on first <leader>e press, then toggles your sanity
  },
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true, -- stalks whatever file you're editing like an obsessed ex
      },
      hijack_netrw_behavior = 'open_current', -- netrw? we don't do that here. begone, ancient one.
    },
    window = {
      width = 30, -- not too wide, not too narrow, just enough to judge your folder structure
      mappings = {
        ['<space>'] = 'none', -- disable space because you probably already mapped it to something else and forgot
      },
    },
  },
}
