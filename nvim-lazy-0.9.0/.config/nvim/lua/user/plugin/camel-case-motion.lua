local M = {}

M.mappings = {
  forward = {
    keys = { '<leader>w'},
    opts = { desc = 'Forward word (camel case)' },
    { { 'n', 'v', 's', 'o' }, '<plug>CamelCaseMotion_w' },
  },
  forward_end = {
    keys = { '<leader>e' },
    opts = { desc = 'End of word (camel case)' },
    { { 'n', 'v', 's', 'o' }, '<plug>CamelCaseMotion_e', },
  },
  back = {
    keys = { '<leader>b' },
    opts = { desc = 'Previous word (camel case)' },
    { { 'n', 'v', 's', 'o' }, '<plug>CamelCaseMotion_b', },
  }, 
}

M.setup = function()
  -- This will enable the default mappings:
  --vim.g.camelcasemotion_key = '<leader>'
end

return M
