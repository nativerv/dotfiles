local M = {}

M.mappings = {
  open = {
    keys = { '<leader>gg' },
    opts = { desc = 'Open Fugitive' },
    { { 'n' }, '<cmd>Gedit :<cr>' },
  },
}

M.setup = function()
end

return M
