
-- | Null-ls
require'null-ls'.setup {
  sources = {
    require'null-ls'.builtins.diagnostics.shellcheck.with {
      diagnostics_format = '[#{c}] #{m} (#{s})',
      filetypes = { 'sh' },
      extra_args = { '-o', 'all' },
    },
    require'null-ls'.builtins.formatting.shfmt,
    require'null-ls'.builtins.formatting.stylua,
  },
  debug = true,
  on_attach = on_attach,
  capabilities = capabilities,
  autostart = true,
}
