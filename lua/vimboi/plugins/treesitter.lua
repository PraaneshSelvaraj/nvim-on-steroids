return {
  -- Let's face it, your code doesn’t work anyway, so at least let’s make it colorful. 
  -- Nothing screams "I care about this project" like some pretty syntax highlighting, right?
  'nvim-treesitter/nvim-treesitter',

  build = ':TSUpdate',

  main = 'nvim-treesitter.configs',

  opts = {
    ensure_installed = {
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'java', 'scala' 
    },
    -- We auto-install missing languages. Because, honestly, who has the time to install stuff themselves?
    auto_install = true,

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
