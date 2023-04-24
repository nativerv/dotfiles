local M = {}

M.setup = function()
  -- Disable the 'v' which-keying for some reason ¯\_(ツ)_/¯
  local presets = require 'which-key.plugins.presets'
  presets.operators['v'] = nil

  -- Mapping: show which-key window
  vim.keymap.set(
    { 'n' },
    '<leader>?',
    require('which-key').show,
    { desc = 'Show key mappings' }
  )

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

  -- TODO: migrate these to their places when they're implemented:
  -- Which-Key descriptions
  if pcall(require, 'which-key') then
    require('which-key').register {
      ['<leader>'] = {
        d = { name = 'Debug...' },
      }
    }
  end
  -- Which-Key descriptions
  if pcall(require, 'which-key') then
    require('which-key').register {
      ['<leader>'] = {
        l = { name = 'Lsp...' },
      }
    }
  end
  -- Which-Key descriptions
  if pcall(require, 'which-key') then
    require('which-key').register {
      ['<leader>'] = {
        t = { name = 'Tests...' },
      }
    }
  end

  -- Default descriptions
  require('which-key').register {
    z = 'Folds, screen, spelling and more...',
    p = 'Put (after cursor)',
    P = 'Put (before cursor)',
    y = 'Yank',
    Y = 'Yank to the end of the line',

    ['<C-l>'] = 'Clear search highlight',
    ['<C-w>'] = 'Window...',
    ['`'] = 'Marks...',
    ['\''] = 'Marks...',
    ['@'] = 'Execute register...',
    ['"'] = 'Use register for next action...',
    ['['] = 'To previous...',
    [']'] = 'To next...',

    -- This is my tmux prefix
    ['<M-`>'] = 'which_key_ignore',
    -- These are bound by `nvim-scrollview`, but i would never need them anyway so here they go
    ['<ScrollWheelUp>'] = 'which_key_ignore',
    ['<ScrollWheelDown>'] = 'which_key_ignore',
    ['<LeftMouse>'] = 'which_key_ignore',
    ['<RightMouse>'] = 'which_key_ignore',

    ['<leader>'] = {
      name = 'More...',
      ['<leader>'] = {
        name = 'More...',
        u = { name = 'Utilities and toggleables...' },
        l = { name = 'Latex...' },
      },
    },
  }

  -- Use terminal's bg
  vim.api.nvim_set_hl(0, 'WhichKeyFloat', {
    bg = 'NONE',
    ctermbg = 'NONE',
  })
end

return M
