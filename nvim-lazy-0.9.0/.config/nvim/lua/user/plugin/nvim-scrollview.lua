local M = {}

M.setup = function()
  require('scrollview').setup {
    excluded_filetypes = { 'nerdtree', 'DiffviewFiles' },
    current_only = true,
    -- winblend = 75,
    -- Position the scrollbar at the 80th character of the buffer
    -- base = 'buffer',
    -- column = 80,
  }
end

return M
