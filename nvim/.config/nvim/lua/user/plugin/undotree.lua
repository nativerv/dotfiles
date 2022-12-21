local M = {}

M.setup = function()
  vim.g.undotree_SplitWidth = 32
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree' })
end

return M
