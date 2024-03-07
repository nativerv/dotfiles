vim.filetype.add({
  extension = {
    bqn = 'bqn',
  },
  pattern = {
  ['.*'] = {
    priority = -math.huge,
    function(path, bufnr)
      local line = vim.filetype.getlines(bufnr, 1)
      if vim.filetype.matchregex(line, [[^#!.*\<bqn\>]]) then
        return 'bqn'
      end
    end,
  },
  },
})
