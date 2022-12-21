local M = {}

M.setup = function()
  require('lsp_lines').setup()

  -- Keybinds
  vim.keymap.set(
    'n',
    '<leader>ll',
    require('lsp_lines').toggle,
    { desc = 'Toggle diagnostic virtual lines' }
  )
end

return M
