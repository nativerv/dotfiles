local M = {}

local shellcheck_diagnostics_cfg = {
  diagnostics_format = '[#{c}] #{m} (#{s})',
  filetypes = { 'sh' },
  extra_args = { '-o', 'all' },
}
local shellcheck_code_actions_cfg = {
  filetypes = { 'sh' },
  extra_args = { '-o', 'all' },
}
local shfmt_formatting_cfg = {
  extra_args = {
    '-i',
    vim.o.tabstop, -- indent
    '-ci', -- switch case indented
    -- '-bn', -- allow && and | to start a new line (breaks pipes with comments)
    '-s', -- simplify the code
  },
}

M.setup = function()
  require('null-ls').setup {
    sources = {
      require('null-ls').builtins.code_actions.shellcheck.with(
        shellcheck_code_actions_cfg
      ),
      require('null-ls').builtins.diagnostics.shellcheck.with(
        shellcheck_diagnostics_cfg
      ),
      require('null-ls').builtins.formatting.shfmt.with(shfmt_formatting_cfg),
      require('null-ls').builtins.formatting.stylua,
      require('null-ls').builtins.formatting.rustfmt,
    },
    debug = true,
    on_attach = require('user.plugin.lspconfig').on_attach,
    capabilities = require('user.plugin.lspconfig').capabilities,
    autostart = true,
  }
end

return M
