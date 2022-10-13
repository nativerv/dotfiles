-- | Vim world
vim.cmd [[
  augroup nrv#mkdir_if_not_exists
    autocmd!
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
  augroup END
]]

-- | Get highlight under cursor
vim.cmd [[
  function! SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc

  function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  endfun
]]

-- | Disable conceallevel (does not fully work)
vim.cmd [[
  augroup nrv#set_conceallevel_0
    autocmd!
    autocmd BufEnter * set conceallevel=0
  augroup END
]]

-- | Enable highlighting of yanked text
vim.cmd [[
  augroup nrv#highlight_yanked
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

  augroup nrv#restore_cursor_after_restart
    autocmd!
    autocmd BufWinEnter * call ResCur()
  augroup END
]]

-- Don't set a background color when running in a terminal;
-- just use the terminal's background color
-- `gui` is the hex color code used in GUI mode/nvim true-color mode
-- `cterm` is the color code used in 256-color mode
-- `cterm16` is the color code used in 16-color mode
-- NOTE:
-- TODO:
-- WARNING:
-- FIXME:

-- *this `autocmd` must be set before `colorscheme` call*
vim.cmd [[
  augroup nrv#uniform_background_color
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE

    " Floats
    autocmd ColorScheme * highlight FloatBorder ctermbg=NONE guibg=NONE
    " autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
    " autocmd ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE

    " LspInfo float border
    autocmd ColorScheme * highlight link LspInfoBorder FloatBorder

    " Line numbers
    autocmd ColorScheme * highlight LineNr ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight CursorLineNr ctermbg=NONE guibg=NONE

    " Signcolumn
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumnSB ctermbg=NONE guibg=NONE

    autocmd ColorScheme * highlight Tabline                          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeBorder                  ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeMatching                ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptPrefix            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptCounter           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeMultiSelection          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeBorder                  ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeMatching                ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeMultiIcon               ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeMultiSelection          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeNormal                  ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewBlock            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewBorder           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewCharDev          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewDate             ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewDirectory        ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewExecute          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewGroup            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewHyphen           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewLine             ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewLink             ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewMatch            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewMessage          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewMessageFillchar  ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewNormal           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewPipe             ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewRead             ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewSize             ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewSocket           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewSticky           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewTitle            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewUser             ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePreviewWrite            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptBorder            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptCounter           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptNormal            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptPrefix            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopePromptTitle             ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsBorder           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsClass            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsComment          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsConstant         ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsDiffAdd          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsDiffChange       ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsDiffDelete       ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsDiffUntracked    ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsField            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsFunction         ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsIdentifier       ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsLineNr           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsMethod           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsNormal           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsNumber           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsOperator         ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsSpecialComment   ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsStruct           ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsTitle            ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeResultsVariable         ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeSelection               ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeSelectionCaret          ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight TelescopeTitle                   ctermbg=NONE guibg=NONE

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
  augroup nrv#uniform_mics_color
    autocmd!

    " Treesitter comment notes
    " NOTE:
    " TODO:
    " WARNING:
    " FIXME:
    autocmd ColorScheme * highlight TSNote ctermbg=NONE guibg=NONE guifg='#61afef'
    autocmd ColorScheme * highlight TSWarning ctermbg=NONE guibg=NONE guifg='#e5c07b'
    autocmd ColorScheme * highlight TSDanger ctermbg=NONE guibg=NONE guifg='#e76671'

    autocmd ColorScheme * highlight Todo ctermbg=NONE guibg=NONE guifg='#e5c07b'

    " Gitsigns/Gitgutter - always use red/green/yellow
    autocmd ColorScheme * highlight GitGutterAdd guifg='#14a573'
    autocmd ColorScheme * highlight GitGutterChange guifg='#deaf6c'
    autocmd ColorScheme * highlight GitGutterDelete guifg='#af404a'

    " Search (variants: #1da9f1 #4183c4)
    autocmd ColorScheme * highlight Search ctermbg=NONE guibg='#4183c4' guifg='#21252b'
    autocmd ColorScheme * highlight IncSearch ctermbg=NONE guibg='#ff9e64' guifg='#21252b'

    " TODO: Refactor all colors with imports from single source
    autocmd ColorScheme * highlight LspDiagnosticsUnderlineError        cterm=undercurl gui=undercurl guisp='#e86671'
    autocmd ColorScheme * highlight LspDiagnosticsUnderlineWarning      cterm=undercurl gui=undercurl guisp='#e5c07b'
    autocmd ColorScheme * highlight LspDiagnosticsUnderlineInformation  cterm=undercurl gui=undercurl guisp='#61afef'
    autocmd ColorScheme * highlight LspDiagnosticsUnderlineHint         cterm=undercurl gui=undercurl guisp='#56b6c2'
    " For some reason i need to specify this (non lsp variant) for
    " undercurl to properly work on hints, replacing the default
    " grey bg cyan text behavior 
    " Also, there seems to be two variants of LspDiagnnostic stuff, with -s, and without.
    " The former (with s) only seems to work. Dunno why, this may break later.
    autocmd ColorScheme * highlight DiagnosticUnderlineHint             cterm=undercurl gui=undercurl guisp='#56b6c2'
  augroup END
]]

-- | Latex
vim.cmd [[
  augroup nrv#compile_latex_on_save
    autocmd!
    autocmd BufWritePost *.tex :lua if vim.g.compile_tex then os.execute('pdflatex -output-directory=' .. vim.fn.expand('%:h') .. ' ' .. vim.fn.expand('%')) end
  augroup END
]]

-- | Open help in full screen - `H` command
vim.cmd [[
  function! s:help(subject)
    let buftype = &buftype
    let &buftype = 'help'
    let v:errmsg = ''
    let cmd = "help " . a:subject
    silent! execute  cmd
    if v:errmsg != ''
      let &buftype = buftype
      return cmd
    else
      call setbufvar('#', '&buftype', buftype)
    endif
  endfunction

  command! -nargs=? -bar -complete=help H execute <SID>help(<q-args>)
]]

-- | Plugin world

-- | Refresh `lualine`'s `pywal` theme on SIGUSR1 (`setwall` sends it)
vim.cmd [[
  augroup nrv#lualine_sigusr1_refresh_wal_theme
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
  augroup nrv#move_vimspector_crap_from_home
    autocmd!
    autocmd User VimspectorDebugEnded call system("mv ~/.vimspector.log " . exists('$XDG_CACHE_HOME') ? $XDG_CACHE_HOME : '~/.cache' . "/nvim/vimspector.log")
  augroup END
]]

vim.cmd [[
  augroup nrv#packer_compile_config
    autocmd!
    autocmd BufWritePost */nvim/*.lua source <afile> | PackerCompile
  augroup end
]]

-- | -- | Help fullscreen
-- | local nrv_help_fullscreen = vim.api.nvim_create_augroup("nrv#open_help_in_fullscreen", { clear = true, })
-- |
