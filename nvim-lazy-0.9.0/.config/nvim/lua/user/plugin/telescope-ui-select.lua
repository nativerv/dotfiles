local M = {}

M.init = function ()
  vim.ui.select = function(...)
    require 'telescope'.load_extension('ui-select')
    return vim.ui.select(...)
  end
end

return M
