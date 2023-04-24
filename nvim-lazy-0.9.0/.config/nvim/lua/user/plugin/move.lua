local M = {}

M.mappings = {
  move_left = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-C-h>' --[[, '<M-C-р>' ]] },
    opts = {},
    { 
      { 'n' }, 
      function() require 'move'.MoveHChar(-1) end, 
      { desc = 'Move char left' } 
    },
    { 
      { 'v' }, 
      function() require 'move'.MoveHBlock(-1) end, 
      { desc = "Move selection left" }
    },
  },
  move_bottom = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-C-j>' --[[, '<M-C-о>' ]] },
    opts = {},
    { 
      { 'n' }, 
      function() require 'move'.MoveLine(1) end, 
      { desc = 'Move char bottom' } 
    },
    { 
      { 'v' }, 
      function() require 'move'.MoveBlock(1) end, 
      { desc = "Move selection bottom" }
    },
  },
  move_top = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-C-k>' --[[, '<M-C-л>' ]] },
    opts = {},
    { 
      { 'n' }, 
      function() require 'move'.MoveLine(-1) end, 
      { desc = 'Move char up' } 
    },
    { 
      { 'v' }, 
      function() require 'move'.MoveBlock(-1) end, 
      { desc = "Move selection up" }
    },
  },
  move_right = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-C-l>' --[[, '<M-C-д>' ]] },
    opts = {},
    { 
      { 'n' }, 
      function() require 'move'.MoveHChar(1) end, 
      { desc = 'Move char right' } 
    },
    { 
      { 'v' }, 
      function() require 'move'.MoveHBlock(1) end, 
      { desc = "Move selection right" }
    },
  },
}

M.setup = function()
  -- require'user.lib.plugin-management'.apply_module_mappings(M.mappings)
end

return M
