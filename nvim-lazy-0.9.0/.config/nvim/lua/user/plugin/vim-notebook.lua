local M = {}

M.mappings = {
  -- hint_words = {
  --   keys = { '<cr>' },
  --   opts = { desc = 'Run APL line' },
  --   { { 'n' }, function() vim.cmd.NotebookEvaluate() end }
  -- },
}

M.setup = function()
  vim.g.notebook_cmd = 'apl --noSV --rawCIN --noColor'
  vim.g.notebook_stop = ')OFF'
  vim.g.notebook_send0 = ""
  vim.g.notebook_send = "'VIMGNUAPLNOTEBOOK'"
  vim.g.notebook_detect = 'VIMGNUAPLNOTEBOOK'

  vim.keymap.set('n', '<cr>', function() vim.cmd.NotebookEvaluate() end)
end

return M
