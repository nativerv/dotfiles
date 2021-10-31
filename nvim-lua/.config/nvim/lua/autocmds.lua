-- | Vim world

-- | Disable conceallevel
vim.cmd [[
  autocmd BufEnter * set conceallevel=0
]]

-- | Plugin world

-- | Refresh `lualine`'s `pywal` theme on SIGUSR1 (`setwall` sends it)
vim.cmd [[
  autocmd Signal SIGUSR1 call LualineRefreshWalTheme()

  function! LualineRefreshWalTheme()
    lua require'lualine'.setup {}
    :redraw
  endfunction
]]

-- | Move vimspector's crap from $HOME
vim.cmd [[
  autocmd User VimspectorDebugEnded call system("mv ~/.vimspector.log " . exists('$XDG_CACHE_HOME') ? $XDG_CACHE_HOME : '~/.cache' . "/vim/")
]]
