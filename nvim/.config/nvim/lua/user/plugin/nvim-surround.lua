local M = {}

M.setup = function()
  require('nvim-surround').setup {}
  -- TODO: seems like this plugin updated/more treesitter stuff addeed

  -- Keymaps
  -- Surround word
  vim.api.nvim_set_keymap('n', 'S', 'ysiw', { noremap = false, silent = true })
end

return M
