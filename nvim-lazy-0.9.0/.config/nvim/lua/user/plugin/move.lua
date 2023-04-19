local M = {}

M.keys = {
  move_left =  { '<A-C-h>', '<A-C-р>' },
  move_down =  { '<A-C-j>', '<A-C-о>' },
  move_up =    { '<A-C-k>', '<A-C-л>' },
  move_right = { '<A-C-l>', '<A-C-д>' },
}

M.setup = function()
  local opts = { noremap = true, silent = true }

  -- Normal mode (single line/char)
  require'user.utils'.map_keys({ 'n' }, M.keys.move_up, function () require 'move'.MoveLine(-1) end) 
  require'user.utils'.map_keys({ 'n' }, M.keys.move_down, function () require 'move'.MoveLine(1) end)
  require'user.utils'.map_keys({ 'n' }, M.keys.move_left, function () require 'move'.MoveHChar(-1) end)
  require'user.utils'.map_keys({ 'n' }, M.keys.move_right, function () require 'move'.MoveHChar(1) end) 

  -- Visual mode (block of lines/chars)
  require'user.utils'.map_keys({ 'v' }, M.keys.move_up, function () require 'move'.MoveBlock(-1) end)
  require'user.utils'.map_keys({ 'v' }, M.keys.move_down, function () require 'move'.MoveBlock(1) end) 
  require'user.utils'.map_keys({ 'v' }, M.keys.move_left, function () require 'move'.MoveHBlock(-1) end) 
  require'user.utils'.map_keys({ 'v' }, M.keys.move_right, function () require 'move'.MoveHBlock(1) end)
end

return M
