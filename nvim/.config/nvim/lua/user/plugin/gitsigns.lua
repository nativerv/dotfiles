local M = {}

M.setup = function()
  local gitsigns_icon_change = '│'
  local gitsigns_icon_remove = ''
  require('gitsigns').setup {
    signs = {
      add = { hl = 'GitGutterAdd', text = gitsigns_icon_change },
      change = { hl = 'GitGutterChange', text = gitsigns_icon_change },
      changedelete = { hl = 'GitGutterChange', text = gitsigns_icon_change },
      delete = { hl = 'GitGutterDelete', text = gitsigns_icon_remove },
      topdelete = { hl = 'GitGutterDelete', text = gitsigns_icon_remove },
    },
    keymaps = {
      -- noremap = true,

      -- -- Goto prev hunk
      -- ['n g['] = {
      --   expr = true,
      --   "&diff ? 'g[' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'",
      -- },
      -- -- Goto next hunk
      -- ['n g]'] = {
      --   expr = true,
      --   "&diff ? 'g]' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'",
      -- },
      -- -- Stage under cursor
      -- ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<cr>',
      -- -- Stage under selection
      -- ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
      -- -- Unstage last
      -- ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
      -- -- Preview hunk (in floating window)
      -- ['n gz'] = '<cmd>lua require"gitsigns".preview_hunk()<cr>',
      -- -- Blame under cursor (show author of hunk)
      -- ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<cr>',
      -- -- Word object - in hunk
      -- ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<cr>',
      -- ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<cr>',

      --['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<cr>',
      --['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
      --['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<cr>',
      --['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<cr>',
      --['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<cr>',
    },
  }
  -- Keymaps
  -- Cycle hunks
  vim.keymap.set({ 'n' }, '<leader>g[', function()
    require('gitsigns').prev_hunk()
  end, { desc = 'Go to prev hunk' })

  vim.keymap.set({ 'n' }, '<leader>g]', function()
    require('gitsigns').next_hunk()
  end, { desc = 'Go to next hunk' })

  -- Stage hunk
  vim.keymap.set({ 'n' }, '<leader>gs', function()
    require('gitsigns').stage_hunk()
  end, { desc = 'Stage hunk under cursor' })

  vim.keymap.set({ 'v' }, '<leader>gs', function()
    require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'Stage hunks under VISUAL selection' })

  -- Undo last staged hunk
  vim.keymap.set({ 'n' }, '<leader>gu', function()
    require('gitsigns').undo_stage_hunk()
  end, { desc = 'Unstage last staged hunk' })

  -- Reset hunk
  vim.keymap.set({ 'n' }, '<leader>gr', function()
    require('gitsigns').reset_hunk()
  end, { desc = 'Reset hunk under cursor' })

  vim.keymap.set({ 'v' }, '<leader>gr', function()
    require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'Reset hunks under VISUAL selection' })

  -- Preview hunk
  vim.keymap.set({ 'n', 'v' }, '<leader>gz', function()
    require('gitsigns').preview_hunk()
  end, { desc = 'Preview hunk under cursor in a float' })

  -- Blame hunk
  vim.keymap.set({ 'n' }, '<leader>gb', function()
    require('gitsigns').blame_line {
      full = true,
      ignore_whitespace = true,
    }
  end, { desc = 'Preview hunk under cursor in a float' })

  -- Textobjects
  -- Select hunk (if you try to translate it to lua it 
  -- wouldn't work because of <C-U> magic)
  vim.keymap.set(
    { 'x', 'o', 'v' },
    'ih',
    ':<C-U>lua require"gitsigns".select_hunk()<cr>',
    { desc = 'Inside git hunk' }
  )
end

return M
