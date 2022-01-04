-- | Vim world

-- | Disable conceallevel (does not fully work)
vim.cmd [[
  augroup set_conceallevel_0
    autocmd!
    autocmd BufEnter * set conceallevel=0
  augroup END
]]

-- | Enable highlighting of yanked text
vim.cmd [[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=150 }
  augroup END
]]

-- | Enable remembering of cursor position between nvim restarts
-- | Start at previous position centered
vim.cmd [[
  function! ResCur()
    if line("'\"") <= line("$")
      normal! g`"zz
      return 1
    endif
  endfunction

  augroup restore_cursor
    autocmd!
    autocmd BufWinEnter * call ResCur()
  augroup END
]]

-- | Don't set a background color when running in a terminal;
-- | just use the terminal's background color
-- | `gui` is the hex color code used in GUI mode/nvim true-color mode
-- | `cterm` is the color code used in 256-color mode
-- | `cterm16` is the color code used in 16-color mode
-- | NOTICE: *this `autocmd` must be set before `colorscheme` call*
-- | NOTICE: test
-- | WARNING: test
-- | DANGER: test
vim.cmd [[
  augroup uniform_background_color
    autocmd!
    " Text
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE

    " Line numbers
    autocmd ColorScheme * highlight LineNr ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight CursorLineNr ctermbg=NONE guibg=NONE

    " Signcolumn
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumnSB ctermbg=NONE guibg=NONE

    autocmd ColorScheme * highlight Tabline ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeBorder ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeMatching ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptPrefix ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptCounter ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeMultiSelection ctermbg=NONE guibg=NONE

    "autocmd ColorScheme * highlight lCursor ctermbg=NONE guibg=NONE
    "autocmd ColorScheme * highlight CursorIM ctermbg=NONE guibg=NONE

    " Foldcolumn
    autocmd ColorScheme * highlight FoldColumn ctermbg=NONE guibg=NONE

    " Popup menu
    "autocmd ColorScheme * highlight Pmenu ctermbg=NONE guibg=NONE " Popup menu: normal item.
    "autocmd ColorScheme * highlight PmenuSel ctermbg=NONE guibg=NONE " Popup menu: selected item.at
    "autocmd ColorScheme * highlight PmenuSbar ctermbg=NONE guibg=NONE " Popup menu: scrollbar.
    "autocmd ColorScheme * highlight PmenuThumb ctermbg=NONE guibg=NONE " Popup menu: Thumb of the scrollbar.

    " Status line
    autocmd ColorScheme * highlight StatusLine ctermbg=NONE guibg=NONE " Status line of current window
    autocmd ColorScheme * highlight StatusLineNC ctermbg=NONE guibg=NONE " Status line of noncurrent window

    " Popup windows
    "autocmd ColorScheme * highlight debugPC ctermbg=NONE guibg=NONE " used for highlighting the current line in terminal-debug 
    "autocmd ColorScheme * highlight BufferTabpageFill ctermbg=NONE guibg=NONE  
    "autocmd ColorScheme * highlight BufferInactive ctermbg=NONE guibg=NONE  
    "autocmd ColorScheme * highlight BufferInactiveIndex ctermbg=NONE guibg=NONE  
    "autocmd ColorScheme * highlight BufferInactiveMod ctermbg=NONE guibg=NONE  
    "autocmd ColorScheme * highlight BufferInactiveTarget ctermbg=NONE guibg=NONE  
    "autocmd ColorScheme * highlight LspTroubleNormal ctermbg=NONE guibg=NONE  
    "autocmd ColorScheme * highlight WhichKeyFloat ctermbg=NONE guibg=NONE  
  augroup END
]]

-- | Uniform colors for notes/marginalias/mics
vim.cmd [[
  augroup uniform_mics_color
    autocmd!

    " Treesitter comment notes
    autocmd ColorScheme * highlight TSNote ctermbg=NONE guibg=NONE guifg='#61afef'
    autocmd ColorScheme * highlight TSWarning ctermbg=NONE guibg=NONE guifg='#e5c07b'
    autocmd ColorScheme * highlight TSDanger ctermbg=NONE guibg=NONE guifg='#e76671'

    " Gitsigns/Gitgutter - always use red/green/yellow
    autocmd ColorScheme * highlight GitGutterAdd ctermbg=NONE guibg=NONE guifg='#14a573'
    autocmd ColorScheme * highlight GitGutterChange ctermbg=NONE guibg=NONE guifg='#deaf6c'
    autocmd ColorScheme * highlight GitGutterDelete ctermbg=NONE guibg=NONE guifg='#af404a'

    " Search (variants: #1da9f1 #4183c4)
    autocmd ColorScheme * highlight Search ctermbg=NONE guibg='#4183c4' guifg='#21252b'
    autocmd ColorScheme * highlight IncSearch ctermbg=NONE guibg='#ff9e64' guifg='#21252b'
  augroup END
]]

-- | Plugin world

-- | Refresh `lualine`'s `pywal` theme on SIGUSR1 (`setwall` sends it)
vim.cmd [[
  augroup lualine_refresh_wal_theme
    autocmd!
    autocmd Signal SIGUSR1 call LualineRefreshWalTheme()
  augroup END

  function! LualineRefreshWalTheme()
    lua require'lualine'.setup {}
    :redraw
  endfunction
]]

-- | Move vimspector's crap from ${HOME}
vim.cmd [[
  augroup vimspector_debug_ended
    autocmd!
    autocmd User VimspectorDebugEnded call system("mv ~/.vimspector.log " . exists('$XDG_CACHE_HOME') ? $XDG_CACHE_HOME : '~/.cache' . "/nvim/vimspector.log")
  augroup END
]]

