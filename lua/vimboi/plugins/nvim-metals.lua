return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Because nothing says "I love bloated dependencies" like adding yet another one.
  },
  ft = { 'scala', 'sbt' }, -- Only load for Scala and SBT files, because why pay attention to anything else?
  opts = function()
    local metals_config = require('metals').bare_config()

    -- Pump up JVM memory because Metals will eat your RAM like it's an all-you-can-eat buffet.
    metals_config.settings = {
      showImplicitArguments = true, -- So you get a front-row seat to all the implicit wizardry you didn't ask for.
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' }, -- Exclude the popular noise so you can focus on your own misery.
      serverProperties = {
        '-Xmx4G', -- Max heap size, give it more RAM if you hate your computer.
        '-Xms1G', -- Initial heap, because Metals likes to start big and only grow bigger.
        '-Xss4M', -- Stack size, stack overflow errors not included.
      },
      -- So you can blame Metals properly when it decides to crash spectacularly.
      serverVersion = 'latest.snapshot', -- Live on the edge—install bugs before anyone else.
    }

    metals_config.init_options.statusBarProvider = 'off' -- Status bar? Nah, you don't need more distractions.
    metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Diagnostic handler that shows errors inline, because who doesn’t love a cluttered screen?
    metals_config.handlers = {
      ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = { prefix = '' }, -- Empty prefix means the errors creep in silently to haunt your code.
      }),
    }

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = self.ft,
      callback = function()
        -- Attach or initialize Metals, because waiting for your compile times to kill you isn’t an option.
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })

    -- Restart Metals automatically if it crashes (which it will, repeatedly).
    vim.api.nvim_create_autocmd('LspDetach', {
      group = nvim_metals_group,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'metals' then
          vim.notify('Metals detached. Attempting restart...', vim.log.levels.WARN) -- Screaming internally.
          vim.defer_fn(function()
            if vim.bo.filetype == 'scala' or vim.bo.filetype == 'sbt' then
              require('metals').initialize_or_attach(metals_config) -- Like a phoenix, it rises... annoyingly.
            end
          end, 2000)
        end
      end,
    })

    -- Commands for those who prefer typing less and whining more.
    vim.api.nvim_create_user_command('MetalsInstall', function()
      require('metals').install_metals()
    end, { desc = 'Install Metals (because copying URLs is overrated)' })

    vim.api.nvim_create_user_command('MetalsRestart', function()
      vim.cmd 'LspRestart metals' -- Restart Metals and pray it stays up this time.
    end, { desc = 'Restart Metals LSP (the perpetual motion machine)' })

    vim.api.nvim_create_user_command('MetalsLogs', function()
      require('metals').open_all_diagnostics() -- Open logs and enjoy the horror show.
    end, { desc = 'Open Metals logs (aka logs of doom)' })

    vim.api.nvim_create_user_command('MetalsInfo', function()
      require('metals').info() -- Show info, so you can pretend you understand what’s going on.
    end, { desc = 'Show Metals info (for the masochists)' })

    vim.api.nvim_create_user_command('MetalsClearCache', function()
      vim.notify('Clearing Metals cache...', vim.log.levels.INFO) -- Because sometimes you gotta smash it and start anew.
      vim.fn.system 'rm -rf .metals .bloop' -- Wipe it all out like it never happened.
      vim.notify('Running sbt bloopInstall...', vim.log.levels.INFO) -- Time to torture sbt again.
      local result = vim.fn.system 'sbt bloopInstall'
      if vim.v.shell_error == 0 then
        vim.notify('Bloop config regenerated. Restarting Metals...', vim.log.levels.INFO) -- Maybe this time it’ll work?
        vim.cmd 'MetalsRestart'
      else
        vim.notify('Failed to run bloopInstall. Check your sbt setup.\n' .. result, vim.log.levels.ERROR) -- Welcome to dependency hell.
      end
    end, { desc = 'Clear Metals cache, regenerate Bloop, and restart (the ritual cleansing)' })
  end,
}
