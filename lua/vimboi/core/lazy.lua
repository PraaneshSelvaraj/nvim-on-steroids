-- Why Lazy? Lazy resembles myself

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy is missing, which it probably is, because nothing is ever simple
if not vim.loop.fs_stat(lazypath) then
  -- Clone it like your repo depends on it — because it does
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none", -- because downloading the whole repo is *too mainstream*
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- go stable, because bleeding edge just means bleeding
    lazypath,
  })
end

-- Prepend lazy to runtime path like it’s the secret ingredient to not losing your mind
vim.opt.rtp:prepend(lazypath)

-- Load plugins from my majestic mess of modules, because monoliths are for boomers
require("lazy").setup({
  { import = "vimboi.plugins" }, -- all plugins go here. Organized chaos™
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

