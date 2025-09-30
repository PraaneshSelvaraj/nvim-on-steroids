-- Vimboi keymaps: because my fingers are fast... *wink*

local keymap = vim.keymap.set

-- Escape = clear search highlights. Because I don’t need my screen screaming at me after every `/`
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Stop highlighting my mistakes' })

-- Open netrw. Yes, I use netrw. Yes, I hate myself.
keymap('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open file explorer like it’s 2004' })

-- Diagnostics. Because I need Neovim to tell me how much I’ve failed today.
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open the “you messed up” list' })

-- Terminal mode: because I somehow always end up stuck in terminal mode like it’s quicksand
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Escape terminal hell' })

-- Quick save. Because hitting `:w` is just *too much* effort apparently
keymap('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save. Because auto-save isn’t real' })

-- Quick quit. Because rage quit is in my DNA.
keymap('n', '<leader>qq', '<cmd>qa!<CR>', { desc = 'Panic quit all' })

-- LLMS are god. I like to worship em.
keymap('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })

keymap('n', '<leader>y', '"+yy', { desc = 'Copy line to system clipboard' })

keymap('n', '<leader>P', '"+p', { desc = 'Paste from system clipboard' })
