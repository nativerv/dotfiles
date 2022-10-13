return function ()
  local gitsigns_icon_change = '│'
  local gitsigns_icon_remove = ''
  require'gitsigns'.setup {
    signs = {
      add          = { hl = 'GitGutterAdd',    text = gitsigns_icon_change, },
      change       = { hl = 'GitGutterChange', text = gitsigns_icon_change, },
      changedelete = { hl = 'GitGutterChange', text = gitsigns_icon_change, },
      delete       = { hl = 'GitGutterDelete', text = gitsigns_icon_remove, },
      topdelete    = { hl = 'GitGutterDelete', text = gitsigns_icon_remove, },
    },
    keymaps = {
      noremap = true,

      -- Goto prev hunk
      ['n g['] = { expr = true, "&diff ? 'g[' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'"},
      -- Goto next hunk
      ['n g]'] = { expr = true, "&diff ? 'g]' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'"},
      -- Stage under cursor
      ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<cr>',
      -- Stage under selection
      ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
      -- Unstage last
      ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
      -- Preview hunk (in floating window)
      ['n gz'] = '<cmd>lua require"gitsigns".preview_hunk()<cr>',
      -- Blame under cursor (show author of hunk)
      ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<cr>',
      -- Word object - in hunk
      ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<cr>',
      ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<cr>'

      --['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<cr>',
      --['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
      --['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<cr>',
      --['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<cr>',
      --['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<cr>',
    },
  }
end

