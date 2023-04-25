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

vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup(
    'nrv#remove_background_color',
    { clear = true }
  ),
  callback = function()
    vim.cmd [[ highlight Normal ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight NormalNC ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight NormalSB ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight NormalFloat ctermbg=NONE guibg=NONE ]] 

    -- Floats
    vim.cmd [[ highlight FloatBorder ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight LspInfoBorder ctermbg=NONE guibg=NONE ]] 

    -- Line numbers
    vim.cmd [[ highlight LineNr ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight CursorLineNr ctermbg=NONE guibg=NONE ]] 

    -- Signcolumn
    vim.cmd [[ highlight SignColumn ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight SignColumnSB ctermbg=NONE guibg=NONE ]] 

    vim.cmd [[ highlight Tabline                          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeBorder                  ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeMatching                ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePromptPrefix            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePromptCounter           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeMultiSelection          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeBorder                  ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeMatching                ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeMultiIcon               ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeMultiSelection          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeNormal                  ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewBlock            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewBorder           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewCharDev          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewDate             ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewDirectory        ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewExecute          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewGroup            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewHyphen           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewLine             ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewLink             ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewMatch            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewMessage          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewMessageFillchar  ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewNormal           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewPipe             ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewRead             ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewSize             ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewSocket           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewSticky           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewTitle            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewUser             ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePreviewWrite            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePromptBorder            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePromptCounter           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePromptNormal            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePromptPrefix            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopePromptTitle             ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsBorder           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsClass            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsComment          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsConstant         ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsDiffAdd          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsDiffChange       ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsDiffDelete       ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsDiffUntracked    ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsField            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsFunction         ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsIdentifier       ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsLineNr           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsMethod           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsNormal           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsNumber           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsOperator         ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsSpecialComment   ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsStruct           ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsTitle            ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeResultsVariable         ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeSelection               ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeSelectionCaret          ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TelescopeTitle                   ctermbg=NONE guibg=NONE ]] 

    --vim.cmd [[ highlight lCursor ctermbg=NONE guibg=NONE ]] 
    --vim.cmd [[ highlight CursorIM ctermbg=NONE guibg=NONE ]] 

    -- Foldcolumn
    vim.cmd [[ highlight FoldColumn ctermbg=NONE guibg=NONE ]] 

    -- Popup menu
    --vim.cmd [[ highlight Pmenu ctermbg=NONE guibg=NONE ]]  -- Popup menu: normal item.
    --vim.cmd [[ highlight PmenuSel ctermbg=NONE guibg=NONE ]]  -- Popup menu: selected item.at
    --vim.cmd [[ highlight PmenuSbar ctermbg=NONE guibg=NONE ]]  -- Popup menu: scrollbar.
    --vim.cmd [[ highlight PmenuThumb ctermbg=NONE guibg=NONE ]]  -- Popup menu: Thumb of the scrollbar.

    -- Status line
    vim.cmd [[ highlight StatusLine ctermbg=NONE guibg=NONE ]]  -- Status line of current window
    vim.cmd [[ highlight StatusLineNC ctermbg=NONE guibg=NONE ]]  -- Status line of noncurrent window

    -- Popup windows
    --vim.cmd [[ highlight debugPC ctermbg=NONE guibg=NONE ]]  -- used for highlighting the current line in terminal-debug
    --vim.cmd [[ highlight BufferTabpageFill ctermbg=NONE guibg=NONE ]] 
    --vim.cmd [[ highlight BufferInactive ctermbg=NONE guibg=NONE ]] 
    --vim.cmd [[ highlight BufferInactiveIndex ctermbg=NONE guibg=NONE ]] 
    --vim.cmd [[ highlight BufferInactiveMod ctermbg=NONE guibg=NONE ]] 
    --vim.cmd [[ highlight BufferInactiveTarget ctermbg=NONE guibg=NONE ]] 
    --vim.cmd [[ highlight LspTroubleNormal ctermbg=NONE guibg=NONE ]] 
    --vim.cmd [[ highlight WhichKeyFloat ctermbg=NONE guibg=NONE ]] 
  end,
})

-- Uniform colors for errors/notes/marginalias/etc
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup(
    'nrv#uniform_mics_color',
    { clear = true }
  ),
  callback = function()
    -- hlgroups for nvim-ts-rainbow and personal use (markdown headers, etc)
    for index, pair in ipairs(require'user.config'.colors.rainbow_colors) do -- p00f/rainbow#81
      local hlgroup, color = pair[1], pair[2]
      vim.api.nvim_set_hl(0, hlgroup, { fg = color, })
      vim.api.nvim_set_hl(0, ('rainbowcol%d'):format(index), { fg = color, })
      vim.api.nvim_set_hl(0, ('RainbowColor%d'):format(index), { fg = color, })
    end

    -- Treesitter comment notes
    -- TODO(scope):
    -- NOTE(scope):
    -- WARNING(scope):
    -- FIXME(scope):
    -- stylua: ignore start
    vim.cmd (([[ highlight @text.note ctermbg=NONE guibg=NONE guifg='%s' ]]):format(require'user.config'.colors.information))
    vim.cmd (([[ highlight @text.warning ctermbg=NONE guibg=NONE guifg='%s' ]]):format(require'user.config'.colors.warning))
    vim.cmd (([[ highlight @text.danger ctermbg=NONE guibg=NONE guifg='%s' ]]):format(require'user.config'.colors.error))
    vim.cmd (([[ highlight @text.todo ctermbg=NONE guibg=NONE guifg='%s' ]]):format(require'user.config'.colors.hint))
    -- stylua: ignore end

    -- Gitsigns/Gitgutter
    vim.cmd (([[ highlight GitGutterAdd guifg='%s' ]]):format(require'user.config'.colors.git.added))
    vim.cmd (([[ highlight GitGutterChange guifg='%s' ]]):format(require'user.config'.colors.git.modified))
    vim.cmd (([[ highlight GitGutterDelete guifg='%s' ]]):format(require'user.config'.colors.git.removed))
    vim.cmd (([[ highlight GitSignsAdd guifg='%s' ]]):format(require'user.config'.colors.git.added))
    vim.cmd (([[ highlight GitSignsChange guifg='%s' ]]):format(require'user.config'.colors.git.modified))
    vim.cmd (([[ highlight GitSignsDelete guifg='%s' ]]):format(require'user.config'.colors.git.removed))

    -- Search (variants: #1da9f1 #4183c4)
    vim.cmd [[ highlight Search ctermbg=NONE guibg='#4183c4' guifg='#21252b' ]] 
    vim.cmd [[ highlight IncSearch ctermbg=NONE guibg='#ff9e64' guifg='#21252b' ]] 

    vim.cmd (([[ highlight DiagnosticsError guisp='%s' ]]):format(require'user.config'.colors.error))
    vim.cmd (([[ highlight DiagnosticsWarning guisp='%s' ]]):format(require'user.config'.colors.warning))
    vim.cmd (([[ highlight DiagnosticsInformation guisp='%s']]):format(require'user.config'.colors.information))
    vim.cmd (([[ highlight DiagnosticsHint guisp='%s' ]]):format(require'user.config'.colors.hint))

    vim.cmd (([[ highlight DiagnosticSignError guifg='%s' ]]):format(require'user.config'.colors.error))
    vim.cmd (([[ highlight DiagnosticSignWarning guifg='%s' ]]):format(require'user.config'.colors.warning))
    vim.cmd (([[ highlight DiagnosticSignInformation guifg='%s' ]]):format(require'user.config'.colors.information))
    vim.cmd (([[ highlight DiagnosticSignHint guifg='%s' ]]):format(require'user.config'.colors.hint))

    vim.cmd (([[ highlight LspDiagnosticsUnderlineError cterm=undercurl gui=undercurl guisp='%s' ]]):format(require'user.config'.colors.error))
    vim.cmd (([[ highlight LspDiagnosticsUnderlineWarning cterm=undercurl gui=undercurl guisp='%s' ]]):format(require'user.config'.colors.warning))
    vim.cmd (([[ highlight LspDiagnosticsUnderlineInformation cterm=undercurl gui=undercurl guisp='%s' ]]):format(require'user.config'.colors.information))
    vim.cmd (([[ highlight LspDiagnosticsUnderlineHint cterm=undercurl gui=undercurl guisp='%s' ]]):format(require'user.config'.colors.hint))

    -- For some reason i need to specify this (non lsp variant) for
    -- undercurl to properly work on hints, replacing the default
    -- grey bg cyan text behavior
    -- Also, there seems to be two variants of LspDiagnnostic stuff, with -s, and without.
    -- Only the former (with s) seems to work. Dunno why, this may break later.
    vim.cmd (([[ highlight DiagnosticUnderlineHint cterm=undercurl gui=undercurl guisp='%s' ]]):format(require'user.config'.colors.hint)) 
  end,
})

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
