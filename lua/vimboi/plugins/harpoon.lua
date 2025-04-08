return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',  -- Because "harpoon2" is clearly the version we’ve all been waiting for. Who needs stable releases when you can live on the edge?
  dependencies = { 'nvim-lua/plenary.nvim' },  -- Oh, and let’s make sure we’re fully dependent on plenary, because why would we want our plugins to be lightweight? More dependencies = more fun, right?

  config = function()
    require('harpoon').setup {
      settings = {
        save_on_toggle = true,  -- Saving your file just by toggling Harpoon? Genius! Forget about manual saves, let’s automate it all. Who needs control, right?
      },
    }
  end,

  keys = {
    {
      '<leader>a',  -- Ah yes, let’s bind 'a' to harpoon, because nothing says “I’m prepared for productivity” like random keybindings.
      function()
        require('harpoon'):list():add()  -- "Just add another file to the list," because we definitely *need* more stuff to juggle in our lives. More chaos, more fun!
      end,
      desc = 'Harpoon file',
    },
    {
      '<C-e>',  -- Control + e. Because nothing screams "quick toggle" like invoking the universe with two hands.
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())  -- Let’s toggle menus on and off, as if we’ve got all the time in the world.
      end,
      desc = 'Toggle Harpoon quick menu',
    },
    {
      '<C-h>',  -- Just go ahead and press Control + h to harpoon to file 1. It’s all part of the “quick-access” dream.
      function()
        require('harpoon'):list():select(1)  -- Sure, let’s select file 1. Why not, right? It’s the first one; it's obvious.
      end,
      desc = 'Harpoon to file 1',
    },
    {
      '<C-t>',  -- Here we are with Control + t, just effortlessly switching between files like it's 1999.
      function()
        require('harpoon'):list():select(2)  -- Selecting file 2, because file 1 wasn't good enough. We’re definitely living on the edge here.
      end,
      desc = 'Harpoon to file 2',
    },
    {
      '<C-n>',  -- Press Control + n to keep the file-selections flowing. We’re just cranking them out, one by one.
      function()
        require('harpoon'):list():select(3)  -- Because selecting the third file is just as easy as choosing between coffee and more coffee.
      end,
      desc = 'Harpoon to file 3',
    },
    {
      '<C-s>',  -- And, of course, Control + s to select file 4. A perfect completion of the "why not?" file carousel.
      function()
        require('harpoon'):list():select(4)  -- Selecting file 4. Why four? Because life’s too short for just three files.
      end,
      desc = 'Harpoon to file 4',
    },
  },
}

