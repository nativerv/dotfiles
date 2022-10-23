-- Expose treesitter-rainbow hl groups 
-- to treesitter queries 
for i = 0, 6 do
  vim.api.nvim_set_hl(
    0,
    string.format('@text.h%d', i),
    { link = string.format('rainbowcol%d', i) }
  )
end
