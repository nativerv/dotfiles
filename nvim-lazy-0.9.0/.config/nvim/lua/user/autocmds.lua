-- Vim world

-- Ensure dir for current file exists (for new files)
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup(
    'nrv#mkdir_if_not_exists',
    { clear = true }
  ),
  callback = function()
    vim.fn.mkdir(vim.fn.expand '<afile>:p:h', 'p')
  end,
})

local function get_visual_text()
  local line_start, col_start = (vim.fn.getpos 'v')[2], (vim.fn.getpos 'v')[3]
  local line_end, col_end = (vim.fn.getpos '.')[2], (vim.fn.getpos '.')[3]

  local lines = vim.fn.getline(line_start, line_end)
  if #lines == 0 then
    return ''
  end

  lines[1] = string.sub(lines[1], col_start, #lines[1])
  lines[#lines] = string.sub(lines[#lines], 1, col_end)

  return table.concat(lines, '\n')
end

-- Put visual selection to OS's `primary` selection
vim.api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup(
    'nrv#visual_selection_to_primary',
    { clear = true }
  ),
  callback = function()
    if string.lower(vim.fn.mode()) == 'v' then
      vim.fn.system {
        'sh',
        '-c',
        "printf '%s' '"
        .. get_visual_text()
        .. "' | xclip -in -selection primary",
      }
    end
  end,
})

-- Enable highlighting of yanked text
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup(
    'nrv#highlight_yanked',
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150 }
  end,
})

-- Enable remembering of cursor position between nvim restarts
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup(
    'nrv#restore_cursor_after_restart',
    { clear = true }
  ),
  callback = function()
    if vim.tbl_contains({ 'commit', 'rebase', 'help' }, vim.o.ft) then return end
    if not (vim.fn.line '\'"' <= vim.fn.line '$') then return end
    vim.cmd [[ normal! g`"zz ]]
  end,
})

-- Don't set a background color when running in a terminal;
-- just use the terminal's background color
-- `gui` is the hex color code used in GUI mode/nvim true-color mode
-- `cterm` is the color code used in 256-color mode
-- `cterm16` is the color code used in 16-color mode
-- NOTE:
-- TODO:
-- WARNING:
-- FIXME:

vim.cmd [[
  augroup nrv#remove_background_color
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalSB ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE

    " Floats
    autocmd ColorScheme * highlight FloatBorder ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight LspInfoBorder ctermbg=NONE guibg=NONE

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

-- Uniform colors for notes/marginalias/mics
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
    autocmd ColorScheme * highlight GitSignsAdd guifg='#14a573'
    autocmd ColorScheme * highlight GitSignsChange guifg='#deaf6c'
    autocmd ColorScheme * highlight GitSignsDelete guifg='#af404a'

    " Search (variants: #1da9f1 #4183c4)
    autocmd ColorScheme * highlight Search ctermbg=NONE guibg='#4183c4' guifg='#21252b'
    autocmd ColorScheme * highlight IncSearch ctermbg=NONE guibg='#ff9e64' guifg='#21252b'

    " TODO: Refactor all colors with imports from single source
    autocmd ColorScheme * highlight DiagnosticsError        guisp='#e86671'
    autocmd ColorScheme * highlight DiagnosticsWarning      guisp='#e5c07b'
    autocmd ColorScheme * highlight DiagnosticsInformation  guisp='#61afef'
    autocmd ColorScheme * highlight DiagnosticsHint         guisp='#56b6c2'

    autocmd ColorScheme * highlight DiagnosticSignError        guifg='#e86671'
    autocmd ColorScheme * highlight DiagnosticSignWarning      guifg='#e5c07b'
    autocmd ColorScheme * highlight DiagnosticSignInformation  guifg='#61afef'
    autocmd ColorScheme * highlight DiagnosticSignHint         guifg='#56b6c2'

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

-- Compile latex on save
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = '*.tex',
  group = vim.api.nvim_create_augroup(
    'nrv#compile_latex_on_save',
    { clear = true }
  ),
  callback = function()
    if vim.g.compile_tex then
      local compile_cmd = string.format(
        'pdflatex -output-directory=%s %s',
        vim.fn.expand '%:h',
        vim.fn.expand '%'
      )
      os.execute(compile_cmd)
    end
  end,
})

-- Set formatoptions - overwrite the default ftplugin, which overwrites options.lua
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup(
    'nrv#set_formatoptions',
    { clear = true }
  ),
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
        -- The following comments is written by TJ, i'll stick this here
        -- and test how i feel about it for some time
        -- Before: :set 'formatoptions' -> jcroql
        - 'a' -- Auto formatting is BAD.
        - 't' -- Don't auto format my code. I got linters for that.
        - 'o' -- O and o, don't continue comments
        - '2' -- I'm not in gradeschool anymore
        + 'j' -- Auto-remove comments if possible.
        + 'n' -- Indent past the formatlistpat, not underneath it.
        - 'c' -- In general, I like it when comments respect textwidth
        - 'r' -- But do continue when pressing enter.
        + 'q' -- Allow formatting comments w/ gq
  end,
})

-- Set markdown specific options
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'markdown',
  group = vim.api.nvim_create_augroup(
    'nrv#markdown_options',
    { clear = true }
  ),
  callback = function()
    vim.opt.wrap = true -- set wrap
    vim.opt.shiftwidth = 4 -- ? something with setting spaces/tabs to 4 spaces
    vim.opt.tabstop = 4 -- ? something with setting spaces/tabs to 4 spaces
    vim.opt.softtabstop = 4 -- ? something with setting spaces/tabs to 4 spaces
    vim.opt.spell = true -- enable spellcheck
    vim.opt.spelllang = 'en,ru' -- spellcheck languages
  end,
})

-- Send message to `zet` instances to change their location
-- TODO: move this somewhere
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufAdd' }, {
  pattern = vim.env.HOME .. '/dox/notes/*',
  group = vim.api.nvim_create_augroup(
    'nrv#send_location_to_zet',
    { clear = true }
  ),
  callback = function()
    vim.fn.system(
      ('zet socket-command location /%s'):format(
        (vim.fn.expand '<afile>:t'):gsub('%.md', '.html'),
        (vim.fn.expand '<afile>:t'):gsub('%.md', '.html')
      )
    )
  end,
})
