local M = {}

M.setup = function()
  require('which-key').setup {
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '', -- symbol prepended to a group
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 75 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
  }
  require('which-key').register {
    ['<leader>'] = {
      u = { name = 'Utilities and toggleables...' },
      g = { name = 'Git...' },
      f = { name = 'Telescope...' },
      d = { name = 'Debug...' },
      ['<leader>'] = {
        name = 'More...',
        l = { name = 'Latex options...' },
      },
    },
  }
end

return M
