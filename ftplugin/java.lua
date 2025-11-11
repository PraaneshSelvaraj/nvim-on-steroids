vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.smartindent = true

local jdtls_package_path = vim.fn.expand '~/.local/share/nvim/mason/packages/jdtls'

local lombok_jar_path = jdtls_package_path .. '/lombok.jar'

local config = {
  cmd = {
    jdtls_package_path .. '/bin/jdtls',

    '--jvm-arg=-javaagent:' .. lombok_jar_path,
  },
  -- Surely, this will work on every machine, right? Just pray the paths don't change, or you'll be *thrilled* to debug this mess.

  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]), -- The magic of file searching. We all love finding the "root" by hoping something's there.
  -- Who needs consistency? Just let Vim hope the root dir will show up eventually, like a miracle. At least it’s not as bad as waiting for Java to compile.
}

require('jdtls').start_or_attach(config) -- Here's where the *real* magic happens. Attaching the LSP... or is it *attaching* us to an endless pit of dependencies?
