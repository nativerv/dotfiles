local M = {}

M.setup = function()
  require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }

  -- Display words
  vim.keymap.set('n', 'f', require('hop').hint_words)
end

return M
