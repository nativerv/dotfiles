local M = {}

M.setup = function ()
  -- Surround word
  vim.api.nvim_set_keymap('n', 'S', 'ysiw', { noremap = false, silent = true })
end

return M
