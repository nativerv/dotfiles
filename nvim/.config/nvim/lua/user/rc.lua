-- This file basically contains stuff that i haven't figured out where to put yet

local wal = require 'user.lib.wal'

-- Set markdown heading colors to ts-rainbow colors
for i = 0, 6 do
  vim.api.nvim_set_hl(
    0,
    string.format('@text.h%d', i),
    { link = string.format('rainbowcol%d', i) }
  )
end

-- Set background of fenced code blocks in markdown
local ts_literal = vim.api.nvim_get_hl_by_name('TSLiteral', true)
vim.api.nvim_set_hl(
  0,
  '@text.literal',
  {
    background = wal.colors.lightened_2_background,
    foreground = ts_literal.foreground,
  }
)

-- Define RenderMarkdown command to render current file with pandoc
vim.api.nvim_create_user_command('RenderMarkdown', function()
  local render_cmd = 'silent !render -o %:p'
  vim.cmd(render_cmd)
end, {
  nargs = 0,
  complete = nil,
  bar = true,
})
