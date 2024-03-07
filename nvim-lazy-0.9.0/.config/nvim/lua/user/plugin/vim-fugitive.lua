local M = {}

M.mappings = {
  open = {
    keys = { '<leader>gg' },
    opts = { desc = 'Open Fugitive' },
    { { 'n' }, '<cmd>Gedit :<cr>' },
  },
}

M.setup = function()
  -- Reverse mapping in Fugitive buffer
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'fugitive' },
    group = vim.api.nvim_create_augroup(
      'nrv#fugitive_mappings',
      { clear = true }
    ),
    callback = function(event)
      vim.keymap.set(
        { 'n' },
        M.mappings.open.keys[1],
        function() vim.api.nvim_buf_delete(event.buf, {}) end,
        { buffer = event.buf, desc = 'Close Fugitive' }
      )
      vim.keymap.set(
        { 'n' },
        'i',
        '=',
        { buffer = event.buf, remap = true, desc = 'Toggle an inline diff of the file under the cursor' }
      )
    end,
  })
end

return M
