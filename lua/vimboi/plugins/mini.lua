return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Because who doesn't need better text objects? Let's add a little magic to selecting parentheses and quotes.
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Seriously, who uses Vim without some kind of statusline these days? Let's keep it simple.
    local statusline = require 'mini.statusline'

    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v' -- Because we're all about being precise.
    end
  end,
}
