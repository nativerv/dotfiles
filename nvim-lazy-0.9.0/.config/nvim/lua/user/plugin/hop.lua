local M = {}

M.mappings = {
  hint_words = {
    keys = { 'f' },
    opts = { desc = 'Hint words' },
    { { 'n' }, function() require('hop').hint_words() end }
  },
}

M.setup = function()
  require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
end

return M
