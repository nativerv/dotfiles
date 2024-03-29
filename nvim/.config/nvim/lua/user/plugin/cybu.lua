local M = {}

M.setup = function()
  require('cybu').setup {
    position = {
      relative_to = 'win', -- win, editor, cursor
      anchor = 'topright', -- topleft, topcenter, topright,
      -- centerleft, center, centerright,
      -- bottomleft, bottomcenter, bottomright
      vertical_offset = 0, -- vertical offset from anchor in lines
      horizontal_offset = 0, -- vertical offset from anchor in columns
      max_win_height = 5, -- height of cybu window in lines
      max_win_width = 0.5, -- integer for absolute in columns
      -- float for relative to win/editor width
    },
    style = {
      path = 'relative', -- absolute, relative, tail (filename only)
      path_abbreviation = 'none', -- none, shortened
      border = 'rounded', -- single, double, rounded, none
      separator = ' ', -- string used as separator
      prefix = '…', -- string used as prefix for truncated paths
      padding = 1, -- left & right padding in number of spaces
      hide_buffer_id = true, -- hide buffer IDs in window
      devicons = {
        enabled = true, -- enable or disable web dev icons
        colored = true, -- enable color for web dev icons
        truncate = true, -- truncate wide icons to one char width
      },
      highlights = { -- see highlights via :highlight
        current_buffer = 'CybuFocus', -- current / selected buffer
        adjacent_buffers = 'CybuAdjacent', -- buffers not in focus
        background = 'CybuBackground', -- window background
        border = 'CybuBorder', -- border of the window
      },
    },
    behavior = { -- set behavior for different modes
      -- show_on_autocmd = 'BufWinEnter',
      mode = {
        default = {
          switch = 'immediate', -- immediate, on_close
          view = 'paging', -- 'paging' | 'rolling'
        },
        last_used = {
          switch = 'on_close', -- immediate, on_close
          view = 'paging', -- 'paging' | 'rolling'
        },
        auto = {
          view = 'paging', -- 'paging' | 'rolling'
        },
      },
    },
    display_time = 750, -- time the cybu window is displayed
    exclude = { -- filetypes, cybu will not be active
      'neo-tree',
      'fugitive',
      'qf',
    },
    fallback = function() end, -- arbitrary fallback function
    -- used in excluded filetypes
  }

  -- vim.keymap.set('n', '<m-i>', function()
  --   require('cybu').cycle 'prev'
  -- end, { desc = 'Prev buffer' })
  --
  -- vim.keymap.set('n', '<m-o>', function()
  --   require('cybu').cycle 'next'
  -- end, { desc = 'Next buffer' })
  --
  -- vim.keymap.set('n', '<m-ш>', function()
  --   require('cybu').cycle 'prev'
  -- end, { desc = 'Prev buffer' })
  --
  -- vim.keymap.set('n', '<m-щ>', function()
  --   require('cybu').cycle 'next'
  -- end, { desc = 'Next buffer' })
  vim.keymap.set('n', '<m-p>', function()
    require('cybu').autocmd()
  end, { desc = 'Peek open buffers' })
  vim.keymap.set('n', '<m-з>', function()
    require('cybu').autocmd()
  end, { desc = 'Peek open buffers' })

  vim.api.nvim_create_autocmd('BufWinEnter', {
    group = vim.api.nvim_create_augroup(
      'nrv#cybu_show_on_buffer_switch',
      { clear = true }
    ),
    callback = function()
      -- Only show Cybu window on real buffers, not on floats (lsp, etc.)
      if vim.api.nvim_win_get_config(0).relative == '' then
        require('cybu').autocmd()
      end
    end,
  })
end

return M
