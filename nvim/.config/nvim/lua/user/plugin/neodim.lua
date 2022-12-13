local M = {}

M.setup = function()
  require('neodim').setup {
    alpha = 0.55,
    blend_color = '#000000',
    update_in_insert = {
      enable = true,
      delay = 100,
    },
    hide = {
      virtual_text = false,
      signs = false,
      underline = true,
    },
  }
end

return M
