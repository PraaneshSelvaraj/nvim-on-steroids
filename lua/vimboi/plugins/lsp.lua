-- LSP more like Luckless Single Person
return {
  -- Main LSP Configuration, because we all need a little more structure in our chaotic lives
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools, because you can't trust your system to do it for you
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} }, -- It's just a loading spinner, but hey, it looks cool
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Define the function to check if the client actually supports a method. Spoiler alert: sometimes it doesn't
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr) -- At least it *might* work
      else
        return client.supports_method(method, { bufnr = bufnr }) -- Who knows if this will actually work
      end
    end

    -- This function gets run when an LSP attaches to a buffer. You’ll see it whenever your LSP works… eventually.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- Helper function to easily define LSP mappings. Because typing it out manually is so 1999
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- LSP key mappings, because we all love keybindings, right?
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Inlay hint toggle. Because who doesn't like a little extra noise in the editor?
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end

        -- Highlight references when cursor hovers over them, because references are clearly begging to be highlighted
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    -- Diagnostic configuration, because you love those error messages popping up every two seconds
    vim.diagnostic.config {
      severity_sort = true, -- Oh yes, let's sort them so we know which one to ignore first
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font
          and {
            text = {
              [vim.diagnostic.severity.ERROR] = '󰅚 ', -- We want something that screams "I messed up"
              [vim.diagnostic.severity.WARN] = '󰀪 ',
              [vim.diagnostic.severity.INFO] = '󰋽 ',
              [vim.diagnostic.severity.HINT] = '󰌶 ',
            },
          }
        or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    -- Setup LSP servers because someone has to do it
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' }, -- Because, who needs snippets anyway? Oh wait, we do
            -- diagnostics = { disable = { 'missing-fields' } }, -- Uncomment to disable warnings. Like they really help.
          },
        },
      },
    }

    -- Ensure the servers are installed. Hopefully they don't fail mid-install
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, { 'stylua' }) -- Can't forget this beautifier
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Setup mason-lspconfig, because we don't trust Neovim to figure it out by itself
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false, -- Let's pretend we're in control
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, require('cmp_nvim_lsp').default_capabilities(), server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
