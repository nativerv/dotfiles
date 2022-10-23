local M = {}

M.setup = function ()
  require'nnn'.setup {
    -- mappings = {
    --   { '<M-h>',  require'tmux'.move_left }   ,
    --   { '<M-j>',  require'tmux'.move_bottom } ,
    --   { '<M-k>',  require'tmux'.move_top }    ,
    --   { '<M-l>',  require'tmux'.move_right }  ,
    --   { '<M-р>',  require'tmux'.move_left }   ,
    --   { '<M-о>',  require'tmux'.move_bottom } ,
    --   { '<M-л>',  require'tmux'.move_top }    ,
    --   { '<M-д>',  require'tmux'.move_right }  ,
    -- },
    windownav = {
      left = '<M-h>',
      -- down = '<M-j>',
      -- left = '<M-k>',
      right = '<M-l>',
      -- left = '<M-р>',
      -- left = '<M-о>',
      -- left = '<M-л>',
      -- left = '<M-д>',
    },
  }

  vim.keymap.set('n', '<leader>r',  '<cmd>NnnExplorer<cr>' )
end

return M
