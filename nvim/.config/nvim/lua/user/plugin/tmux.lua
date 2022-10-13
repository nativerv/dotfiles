return function ()
  require'tmux'.setup {
    navigation = {
      -- | Cycles to opposite pane while navigating into the border
      cycle_navigation = false,
    },
  }
end

