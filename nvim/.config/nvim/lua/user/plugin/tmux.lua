local M = {}

M.setup = function()
  require('tmux').setup {
    navigation = {
      -- | Cycles to opposite pane while navigating into the border
      cycle_navigation = false,
    },
  }

  -- Keymaps
  vim.keymap.set('', '<M-h>', require('tmux').move_left)
  vim.keymap.set('', '<M-j>', require('tmux').move_bottom)
  vim.keymap.set('', '<M-k>', require('tmux').move_top)
  vim.keymap.set('', '<M-l>', require('tmux').move_right)
  vim.keymap.set('', '<M-р>', require('tmux').move_left)
  vim.keymap.set('', '<M-о>', require('tmux').move_bottom)
  vim.keymap.set('', '<M-л>', require('tmux').move_top)
  vim.keymap.set('', '<M-д>', require('tmux').move_right)
end

return M
