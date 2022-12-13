local M = {}

M.setup = function()
  -- This will enable the default mappings:
  --vim.g.camelcasemotion_key = '<leader>'

  -- Instead, default my own:
  vim.keymap.set(
    { 'n', 'v', 's', 'o' },
    '<leader>w',
    '<plug>CamelCaseMotion_w',
    { desc = 'Forward word respecting camel case' }
  )
  vim.keymap.set(
    { 'n', 'v', 's', 'o' },
    '<leader>e',
    '<plug>CamelCaseMotion_e',
    { desc = 'Go to the end of word respecting camel case' }
  )
  vim.keymap.set(
    { 'n', 'v', 's', 'o' },
    '<leader>b',
    '<plug>CamelCaseMotion_b',
    { desc = 'Backward word respecting camel case' }
  )
end

return M
