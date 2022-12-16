local M = {}

M.setup = function()
  require('null-ls').setup {
    sources = {
      require('null-ls').builtins.diagnostics.shellcheck.with {
        diagnostics_format = '[#{c}] #{m} (#{s})',
        filetypes = { 'sh' },
        extra_args = { '-o', 'all' },
      },
      require('null-ls').builtins.formatting.shfmt.with {
        extra_args = {
          '-i',
          vim.o.tabstop, -- indent
          '-ci', -- switch case indented
          '-bn', -- allow && and | to start a new line
          '-s', -- simplify the code
        },
      },
      require('null-ls').builtins.formatting.stylua,
      -- require('null-ls').builtins.formatting.rustfmt,
    },
    debug = true,
    on_attach = require('user.plugin.lspconfig').on_attach,
    capabilities = require('user.plugin.lspconfig').capabilities,
    autostart = true,
  }
end

return M
