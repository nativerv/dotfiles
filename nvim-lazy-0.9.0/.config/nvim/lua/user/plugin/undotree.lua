local M = {}

M.mappings = {
  {
    keys = { '<leader>u' },
    { { 'n' }, vim.cmd.UndotreeToggle },
    opts = { desc = 'Undotree', },
  },
}

M.setup = function()
  vim.g.undotree_SplitWidth = 32
end

return M
