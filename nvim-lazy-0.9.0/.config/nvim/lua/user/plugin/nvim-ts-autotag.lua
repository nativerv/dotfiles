local M = {}

M.setup = function()
  require('nvim-treesitter.configs').setup {
    autotag = {
      enable = true,
    },
    enable_rename = false,
  }
end

return M
