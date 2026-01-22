return {
  -- Let's face it, your code doesn't work anyway, so at least let's make it colorful.
  -- Nothing screams "I care about this project" like some pretty syntax highlighting, right?
  'nvim-treesitter/nvim-treesitter',

  branch = 'master', -- Stable branch - no tree-sitter CLI required

  main = 'nvim-treesitter.configs',

  opts = {
    -- Essential parsers that are pre-installed
    ensure_installed = {
      'lua',
      'vim',
      'vimdoc',
      'bash',
      'python',
      'java',
    },

    -- Auto-install is disabled because we have a custom autocmd that does it per-filetype
    auto_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },

    indent = {
      enable = true,
      disable = { 'ruby' }
    },
  }
}
