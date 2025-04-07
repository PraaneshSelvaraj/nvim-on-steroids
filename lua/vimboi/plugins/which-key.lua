-- which-key.nvim — for the forgetful, the hopeless, and those who remap <Esc> to therapy

return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- because god forbid we load this *before* you're ready
  opts = {
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
      -- If you have a Nerd Font, congrats. You're better than most.
      -- If not, here's a sad attempt to compensate.
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>', F2 = '<F2>', F3 = '<F3>', F4 = '<F4>',
        F5 = '<F5>', F6 = '<F6>', F7 = '<F7>', F8 = '<F8>',
        F9 = '<F9>', F10 = '<F10>', F11 = '<F11>', F12 = '<F12>',
      },
    },

    -- Pretending you're organized by categorizing your chaos
    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } }, -- like you'll remember what this does
      { '<leader>d', group = '[D]ocument' }, -- lies. there's no documentation
      { '<leader>r', group = '[R]ename' }, -- you'll rename it five more times anyway
      { '<leader>s', group = '[S]earch' }, -- or just forget what you’re looking for
      { '<leader>w', group = '[W]orkspace' }, -- if you actually have one
      { '<leader>t', group = '[T]oggle' }, -- because you just can't decide
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- for those tiny regretful changes
    },
  },
}

