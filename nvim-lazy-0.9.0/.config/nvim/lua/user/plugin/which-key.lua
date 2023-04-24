local M = {}

M.setup = function()
  local presets = require 'which-key.plugins.presets'
  presets.operators['v'] = nil

  -- Show which-key window
  vim.keymap.set({ 'n' }, '<leader>?', require'which-key'.show, { desc = 'Show key mappings' })

  -- Which-key settings
  require('which-key').setup {
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '->', -- symbol used between a key and it's label
      group = '', -- symbol prepended to a group
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 75 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    window = {
      border = 'single', -- none, single, double, shadow
      padding = { 0, 1, 0, 1 }, -- extra window padding [top, right, bottom, left]
    },
  }

  -- Default descriptions
  require('which-key').register {
    g = {
      c = 'Comment linewise...',
      C = 'Comment blockwise...',
    },
    ['<C-l>'] = 'Clear search highlight',
    ['<ScrollWheelUp>'] = 'which_key_ignore',
    ['<ScrollWheelDown>'] = 'which_key_ignore',
    ['<LeftMouse>'] = 'which_key_ignore',
    ['<RightMouse>'] = 'which_key_ignore',
    ['<C-w>'] = 'Window...',
    ['`'] = 'Marks...',
    ['\''] = 'Marks...',
    ['@'] = 'Execute register...',
    ['"'] = 'Use register for next action...',
    ['['] = 'To previous...',
    [']'] = 'To next...',
    ['<M-`>'] = 'which_key_ignore',
    z = 'Folds, screen, spelling and more...',
    p = 'Put (after cursor)',
    P = 'Put (before cursor)',
    y = 'Yank',
    Y = 'Yank to the end of the line',
    ['<leader>'] = {
      name = 'More...',
      f = { name = 'Telescope...' },
      d = { name = 'Debug...' },
      l = { name = 'Lsp...' },
      t = { name = 'Tests...' },
      ['<leader>'] = {
        name = 'More...',
        u = { name = 'Utilities and toggleables...' },
        l = { name = 'Latex...' },
      },
    },
  }

  vim.api.nvim_set_hl(0, 'WhichKeyFloat', {
    bg = 'NONE',
    ctermbg = 'NONE',
  })
end

return M
