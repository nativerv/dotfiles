-- This file basically contains stuff that i haven't figured out where to put yet

-- Set markdown heading colors to ts-rainbow colors
for i = 0, 6 do
  vim.api.nvim_set_hl(
    0,
    string.format('@markup.heading.%d.markdown', i),
    { link = string.format('RainbowColor%d', i) }
  )
end

-- Set background of fenced code blocks in markdown
-- local ts_literal = vim.api.nvim_get_hl_by_name('TSLiteral', true)
-- local wal = require 'user.lib.wal'
--
-- vim.api.nvim_set_hl(
--   0,
--   '@text.literal',
--   {
--     background = wal.colors.lightened_2_background,
--     foreground = ts_literal.foreground,
--   }
-- )

-- Define Zet command to open current markdown file rendered and hosted with `zet` script
vim.api.nvim_create_user_command('Zet', function()
  local cmd = 'silent !xdg-open http://zet.local/' .. (vim.fn.expand '%:t'):gsub('%.md', '.html')
  vim.cmd(cmd)
end, {
  nargs = 0,
  complete = nil,
  bar = true,
})

