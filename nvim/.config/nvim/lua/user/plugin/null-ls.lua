local M = {}

M.setup = function()
  require('null-ls').setup {
    sources = {
      require('null-ls').builtins.diagnostics.shellcheck.with {
        diagnostics_format = '[#{c}] #{m} (#{s})',
        filetypes = { 'sh' },
        extra_args = { '-o', 'all' },
      },
      require('null-ls').builtins.formatting.shfmt,
      require('null-ls').builtins.formatting.stylua,
    },
    debug = true,
    on_attach = require'user.plugin.lspconfig'.on_attach,
    capabilities = require'user.plugin.lspconfig'.capabilities,
    autostart = true,
  }
end

return M
