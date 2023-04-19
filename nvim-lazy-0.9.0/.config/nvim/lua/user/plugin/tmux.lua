local M = {}

M.setup = function()
  require('tmux').setup {
    navigation = {
      -- | Cycles to opposite pane while navigating into the border
      cycle_navigation = false,
    },
  }

  -- Keymaps
  vim.keymap.set({ 'n', 'i', 'v', 'x', 'o', }, '<M-h>', require('tmux').move_left)
  vim.keymap.set({ 'n', 'i', 'v', 'x', 'o', }, '<M-j>', require('tmux').move_bottom)
  vim.keymap.set({ 'n', 'i', 'v', 'x', 'o', }, '<M-k>', require('tmux').move_top)
  vim.keymap.set({ 'n', 'i', 'v', 'x', 'o', }, '<M-l>', require('tmux').move_right)
  vim.keymap.set({ 'n', 'i', 'v', 'x', 'o', }, '<M-р>', require('tmux').move_left)
  vim.keymap.set({ 'n', 'i', 'v', 'x', 'o', }, '<M-о>', require('tmux').move_bottom)
  vim.keymap.set({ 'n', 'i', 'v', 'x', 'o', }, '<M-л>', require('tmux').move_top)
  vim.keymap.set({ 'n', 'i', 'v', 'x', 'o', }, '<M-д>', require('tmux').move_right)
end

return M
