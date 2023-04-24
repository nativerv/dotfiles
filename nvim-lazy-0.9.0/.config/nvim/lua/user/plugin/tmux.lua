local M = {}

M.mappings = {
  move_left = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-h>', --[[ '<M-р>' ]] },
    opts = { desc = 'Switch to pane left' },
    {
      { 'n', 'i', 'v', 'x', 'o' },
      function()
        require('tmux').move_left()
      end,
    },
  },
  move_bottom = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-j>', --[[ '<M-о>' ]] },
    opts = { desc = 'Switch to pane down' },
    {
      { 'n', 'i', 'v', 'x', 'o' },
      function()
        require('tmux').move_bottom()
      end,
    },
  },
  move_top = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-k>', --[[ '<M-л>' ]] },
    opts = { desc = 'Switch to pane up' },
    {
      { 'n', 'i', 'v', 'x', 'o' },
      function()
        require('tmux').move_top()
      end,
    },
  },
  move_right = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-l>', --[[ '<M-д>' ]] },
    opts = { desc = 'Switch to pane right' },
    {
      { 'n', 'i', 'v', 'x', 'o' },
      function()
        require('tmux').move_right()
      end,
    },
  },
  resize_left = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-`><M-h>', --[[ '<M-`><M-р>' ]] },
    opts = { desc = 'Switch to pane left' },
    {
      { 'n', 'i', 'v', 'x', 'o' },
      function()
        require('tmux').resize_left()
      end,
    },
  },
  resize_bottom = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-`><M-j>', --[[ '<M-`><M-о>' ]] },
    opts = { desc = 'Switch to pane down' },
    {
      { 'n', 'i', 'v', 'x', 'o' },
      function()
        require('tmux').resize_bottom()
      end,
    },
  },
  resize_top = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-`><M-k>', --[[ '<M-`><M-л>' ]] },
    opts = { desc = 'Switch to pane up' },
    {
      { 'n', 'i', 'v', 'x', 'o' },
      function()
        require('tmux').resize_top()
      end,
    },
  },
  resize_right = {
    -- TODO: terminal that supports cyrillic modkey escape codes
    keys = { '<M-`><M-l>', --[[ '<M-`><M-д>' ]] },
    opts = { desc = 'Switch to pane right' },
    {
      { 'n', 'i', 'v', 'x', 'o' },
      function()
        require('tmux').resize_right()
      end,
    },
  },
}

M.setup = function()
  require('tmux').setup {
    copy_sync = {
      -- enables copy sync. by default, all registers are synchronized.
      -- to control which registers are synced, see the `sync_*` options.
      enable = true,

      -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
      -- first buffer or named_buffer_name = true to ignore a named tmux
      -- buffer with name named_buffer_name :)
      ignore_buffers = { empty = false },

      -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
      -- clipboard by tmux
      redirect_to_clipboard = false,

      -- offset controls where register sync starts
      -- e.g. offset 2 lets registers 0 and 1 untouched
      register_offset = 0,

      -- overwrites vim.g.clipboard to redirect * and + to the system
      -- clipboard using tmux. If you sync your system clipboard without tmux,
      -- disable this option!
      sync_clipboard = true,

      -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
      sync_registers = true,

      -- syncs deletes with tmux clipboard as well, it is adviced to
      -- do so. Nvim does not allow syncing registers 0 and 1 without
      -- overwriting the unnamed register. Thus, ddp would not be possible.
      sync_deletes = true,

      -- syncs the unnamed register with the first buffer entry from tmux.
      sync_unnamed = true,
    },
    navigation = {
      -- disable cycling to opposite pane while navigating into the border
      cycle_navigation = false,

      -- enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = false,

      -- prevents unzoom tmux when navigating beyond vim border
      persist_zoom = false,
    },
    resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = false,

      -- sets resize steps for x axis
      resize_step_x = 5,

      -- sets resize steps for y axis
      resize_step_y = 5,
    },
  }
end

return M
