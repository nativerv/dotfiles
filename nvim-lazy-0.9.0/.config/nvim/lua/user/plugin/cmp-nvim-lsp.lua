local M = {}

M.setup = function()
  local lspconfig_config = require 'user.plugin.lspconfig'
  lspconfig_config.capabilities =
    require('cmp_nvim_lsp').update_capabilities(lspconfig_config.capabilities)
end

return M
