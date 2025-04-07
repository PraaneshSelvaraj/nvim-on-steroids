-- ~/.config/nvim/lua/vimboi/plugins/lazydev.lua

return {
  -- "folke/lazydev.nvim" for Lua LSP support, because of course we need extra help managing Neovim's Lua APIs
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- Only for Lua files, so your neovim config doesn't get jealous
    opts = {
      library = {
        -- Load luvit types when `vim.uv` is found, because who doesn’t like making things "more Lua"
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}

