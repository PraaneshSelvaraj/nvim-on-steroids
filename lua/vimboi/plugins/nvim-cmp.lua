return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter', -- Because, who needs to wait for actual events, right?
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Of course, windows will make everything harder, as usual.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp' -- Because we all *love* making things harder with JS regex, right?
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        -- Because writing your own snippets is apparently *way* too much effort.
        -- You could do this... but you're probably too busy scrolling Reddit, aren't you?
      },
    },
    'saadparwaiz1/cmp_luasnip', -- The ultimate, because who can resist more snips?

    -- Adds other completion capabilities.
    -- nvim-cmp doesn't ship with all sources by default. Who needs that? Let's just add them one by one and confuse everyone.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help', -- Oh yes, let's *definitely* add those signature help sources, because why not?
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {} -- Because setting up snippets is *so* much fun.

    -- Kind icons because plain text completion is for peasants
    local kind_icons = {
      Text = '󰦨',
      Method = '󰆧',
      Function = '󰊕',
      Constructor = '',
      Field = '',
      Variable = '󰀫',
      Class = '󰠱',
      Interface = '',
      Module = '',
      Property = '󰜢',
      Unit = '󰑭',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰏿',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '',
      Misc = '',
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Oh look, we're expanding snippets like it's an Olympic event.
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- For an understanding of why these mappings were
      -- Don't worry, we know you won't. Just *trust* us on this one.
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item, because the current one just isn’t as perfect as the next one.
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item, as clearly going backwards is always the best decision in life.
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window [b]ack / [f]orward.
        -- I mean, who doesn't like a good scroll fest?
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion. Because *finally*, it's your turn to be right.
        -- This will auto-import if your LSP supports it.
        -- This will expand snippets if the LSP sent a snippet. It's basically magic, but you didn't have to do anything for it.
        ['<C-y>'] = cmp.mapping.confirm { select = true },

        -- If you prefer more traditional completion keymaps, feel free to uncomment the following lines.
        -- But honestly, who still uses traditional completion? Just go full-on with nvim-cmp and regret it later.
        --['<CR>'] = cmp.mapping.confirm { select = true },
        --['<Tab>'] = cmp.mapping.select_next_item(),
        --['<S-Tab>'] = cmp.mapping.select_prev_item(),

        -- Manually trigger a completion from nvim-cmp.
        -- Because, you know, triggering things manually is always the *best* way to do things.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        -- Or think of it as the most pointless thing you’ll ever do today.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump() -- Just jumping to the right, like you’re making life decisions at 3 AM.
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1) -- Because you *always* need to go backwards, right?
          end
        end, { 'i', 's' }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        -- But let's be real: you're probably never going to read this link. #YouDoYou
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          -- Show fancy icons next to completion items because we're all about that aesthetic life
          local kind = vim_item.kind
          vim_item.kind = string.format('%s', kind_icons[kind])
          vim_item.menu = string.format('%s', kind)
          return vim_item
        end,
      },
      sources = {
        {
          name = 'lazydev', -- Yeah, we’re being lazy with this development process... and it’s working perfectly.
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' }, -- Because you *have* to have LSP completions, who cares about anything else?
        { name = 'luasnip' }, -- Snippets are a *luxury*, and you're living the dream with them.
        { name = 'path' }, -- Of course, because navigating paths manually was just way too easy.
        { name = 'nvim_lsp_signature_help' }, -- Signatures... because looking at code is never enough without signatures, right?
      },
    }
  end,
}
