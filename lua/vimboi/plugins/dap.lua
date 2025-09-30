return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI, because obviously debugging isn’t painful enough without some fancy graphics.
    'rcarriga/nvim-dap-ui',
    -- Handles async stuff because your debug adapter will panic if it multitasks like you.
    'nvim-neotest/nvim-nio',
    -- Installs tools for you, because you clearly weren’t going to do it manually without crying.
    'williamboman/mason.nvim',
    -- Manages debugger installations, because maintaining system-wide debugger setups is for masochists.
    'jay-babu/mason-nvim-dap.nvim',
  },

  keys = {
    -- Your debugging hotkeys, because memorizing GDB commands makes you look cool, but this ain’t the 90s.
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint with Condition (when you want to pretend you’re cleverer than `if` statements)',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Show UI (a.k.a. watch your code implode in high definition)',
    },
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Auto-install all the things, because you can’t be trusted to run “pip install debugpy” yourself.
    require('mason-nvim-dap').setup {
      automatic_installation = true, -- Automagic debugger setup, because reading docs is for chumps.
      handlers = {}, -- You could add handlers here… but let’s face it, you won’t.
      ensure_installed = {
        'debugpy', -- Because Python bugs are eternal, might as well embrace them.
        'scala', -- For when your stack traces need to be *really* unreadable.
      },
    }

    -- Eye-candy for debugging, because staring at plain logs makes you cry at 3am.
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸', -- Because you’ll be pausing more than actually coding.
          play = '▶', -- Hope this works. Spoiler: it won’t.
          step_into = '⏎', -- Dive deeper into the abyss of your spaghetti.
          step_over = '⏭', -- Step over like you’re avoiding responsibility.
          step_out = '⏮', -- Run away from this function like it owes you money.
          step_back = 'b', -- Not available in some debuggers, but hey, dreams are free.
          run_last = '▶▶', -- Re-run your last disaster.
          terminate = '⏹', -- The sweet mercy button.
          disconnect = '⏏', -- Eject your sanity and call it a day.
        },
      },
    }

    -- Automatically open dap-ui when you start and close it when you give up.
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Python debug config, because you’ll never fix that “NoneType has no attribute” anyway.
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}', -- Debug the current file, aka the one you’ve been cursing at for hours.
        pythonPath = function()
          return '/usr/bin/python3' -- Change this if you enjoy virtualenv-induced rage.
        end,
      },
    }
  end,
}
