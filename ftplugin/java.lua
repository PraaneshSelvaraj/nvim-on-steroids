local config = {
  cmd = {
    vim.fn.expand '~/.local/share/nvim/mason/packages/jdtls/bin/jdtls',
  },
  -- Surely, this will work on every machine, right? Just pray the paths don't change, or you'll be *thrilled* to debug this mess.

  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]), -- The magic of file searching. We all love finding the "root" by hoping something's there.
  -- Who needs consistency? Just let Vim hope the root dir will show up eventually, like a miracle. At least it’s not as bad as waiting for Java to compile.
}

require('jdtls').start_or_attach(config) -- Here's where the *real* magic happens. Attaching the LSP... or is it *attaching* us to an endless pit of dependencies?
