local M = {}

M.setup = function ()
  require'colorizer'.setup {
    md = {
      names = false,
    },
  }
end

return M
