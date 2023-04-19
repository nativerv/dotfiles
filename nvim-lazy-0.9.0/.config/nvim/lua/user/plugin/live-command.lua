local M = {}

M.setup = function()
  require('live-command').setup {
    commands = {
      Norm = { cmd = 'norm' },
    },
  }
end

return M
