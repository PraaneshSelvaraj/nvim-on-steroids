-- Vimboi config: handcrafted at 2am by a bro who thought writing his own Neovim config would be “fun”

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Obviously, we have Nerd Font. We’re not animals.
vim.g.have_nerd_font = true

-- Show me the numbers. All of them.
vim.opt.number = true
vim.opt.relativenumber = true

-- Enabling mouse because I like to pretend this is VS Code sometimes.
vim.opt.mouse = 'a'

-- Don't show the mode. I already know I'm in Normal mode because nothing is working.
vim.opt.showmode = false


-- Clipboard syncing so I can copy code from ChatGPT directly into my misery
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Break indent, because code should be *visually* broken, just like me
vim.opt.breakindent = true

-- Persistent undo: so I can "u" my way out of bad life choices (temporarily)
vim.opt.undofile = true

-- Ignore case unless I yell — pretty much how I code anyway
vim.opt.smartcase = true

-- Always flex that sign column
vim.opt.signcolumn = 'yes'

-- Speed tweaks so I can lag 3ms less while writing bugs faster
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Splits go right and down. Unlike my life, which goes left and into the void
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show whitespace chars to constantly remind me I hit spacebar 37 times instead of just using `:retab`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Live substitution so I can ruin everything *before* hitting enter
vim.opt.inccommand = 'split'

-- Highlight the current line because apparently, my eyeballs aren’t good enough
vim.opt.cursorline = true

-- Scrolloff = 10 because edge of screen = fear zone
vim.opt.scrolloff = 10

-- Confirm to quit like, “Are you sure bro?”
vim.opt.confirm = true
