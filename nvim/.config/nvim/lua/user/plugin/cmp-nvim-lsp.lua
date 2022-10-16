local M = {}

M.setup = function()
  M.capabilities = require('cmp_nvim_lsp').update_capabilities(M.capabilities)
end

return M
