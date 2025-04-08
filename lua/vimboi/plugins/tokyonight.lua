return {
  -- Because obviously, the most important thing in our editor is *vibes*.
  -- Everything's broken, but at least it looks good. Priorities, right?
  'folke/tokyonight.nvim',
  priority = 1000, -- Because this is literally more important than my sleep schedule.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      styles = {
        comments = { italic = false }, -- Because leaning comments are just too *emotional* for me.
      },
    }

    -- Load that dreamy dark mode because the light theme is for the brave... or the blind.
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
