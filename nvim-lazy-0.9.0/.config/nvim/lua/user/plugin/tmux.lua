local M = {}
-- { "<M-h>", function () require'tmux'.move_left, desc = "Switch to pane left" end },
-- { "<M-j>", function () require'tmux'.move_bottom, desc = "Switch to pane bottom" end },
-- { "<M-k>", function () require'tmux'.move_top, desc = "Switch to pane top" end },
-- { "<M-l>", function () require'tmux'.move_right, desc = "Switch to pane right" end },

-- { "<M-р>", function () require'tmux'.move_left, desc = "Switch to pane left" end },
-- { "<M-о>", function () require'tmux'.move_bottom, desc = "Switch to pane bottom" end },
-- { "<M-л>", function () require'tmux'.move_top, desc = "Switch to pane top" end },
-- { "<M-д>", function () require'tmux'.move_right, desc = "Switch to pane right" end },

M.keys = { 
  move_left = { "<M-h>", "<M-р>" }, 
  move_bottom = { "<M-j>", "<M-о>" }, 
  move_top = { "<M-k>", "<M-л>" },
  move_right = { "<M-l>", "<M-д>" }, 
}

M.setup = function()
  require('tmux').setup {
    navigation = {
      -- Disable cycling to opposite pane while navigating into the border
      cycle_navigation = false,
    },
  }

  -- Keymaps
  require'user.utils'.map_keys({ 'n', 'i', 'v', 'x', 'o', }, M.keys.move_left, require('tmux').move_left)
  require'user.utils'.map_keys({ 'n', 'i', 'v', 'x', 'o', }, M.keys.move_bottom, require('tmux').move_bottom)
  require'user.utils'.map_keys({ 'n', 'i', 'v', 'x', 'o', }, M.keys.move_top, require('tmux').move_top)
  require'user.utils'.map_keys({ 'n', 'i', 'v', 'x', 'o', }, M.keys.move_right, require('tmux').move_right)
end

return M
