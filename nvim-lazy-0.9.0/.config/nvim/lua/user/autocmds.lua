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
  -- guard -- nothing selected
  if vim.fn.mode():lower() ~= 'v' then return '' end

  local line_start, col_start = (vim.fn.getpos 'v')[2], (vim.fn.getpos 'v')[3]
  local line_end, col_end = (vim.fn.getpos '.')[2], (vim.fn.getpos '.')[3]

  -- validate the range
  if line_start > line_end then
    line_end, line_start = line_start, line_end 
    col_end, col_start = col_start, col_end 
  end

  -- get line range
  local lines = vim.fn.getline(line_start, line_end)

  -- case: `visual line` -- don't crop
  if vim.fn.mode() == 'V' then return table.concat(lines, '\n') end

  -- case: `visual`, same line -- crop ends
  if line_start == line_end then
    -- validate the range
    if col_start > col_end then
      col_end, col_start = col_start, col_end 
    end
    lines[1] = lines[1]:sub(col_start, col_end)
  end

  -- case: `visual`, different lines -- crop ends
  if line_start ~= line_end then
    lines[1] = lines[1]:sub(col_start, #lines[1])
    lines[#lines] = lines[#lines]:sub(1, col_end)
  end

  return table.concat(lines, '\n')
end

-- Yank visual selection to OS's `primary` selection
vim.api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup(
    'nrv#visual_selection_to_primary',
    { clear = true }
  ),
  callback = function()
    if vim.fn.mode():lower() == 'v' then 
      vim.fn.setreg('*', get_visual_text())
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
    if
      vim.tbl_contains({
        'commit',
        'rebase',
        'help',
        'fugitive',
      }, vim.o.ft)
    then
      return
    end
    if not (vim.fn.line '\'"' <= vim.fn.line '$') then
      return
    end
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
    vim.cmd [[ highlight TabLine ctermbg=NONE guibg=NONE ]] 
    vim.cmd [[ highlight TabLineFill ctermbg=NONE guibg=NONE ]] 

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

    -- Foldcolumn
    vim.cmd [[ highlight FoldColumn ctermbg=NONE guibg=NONE ]] 

    -- Status line
    vim.cmd [[ highlight StatusLine ctermbg=NONE guibg=NONE ]]  -- Status line of current window
    vim.cmd [[ highlight StatusLineNC ctermbg=NONE guibg=NONE ]]  -- Status line of noncurrent window
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

    -- Error, Warning, Information, Hint
    vim.api.nvim_set_hl(0, 'Error', { fg = require'user.config'.colors.error })
    vim.api.nvim_set_hl(0, 'Warning', { fg = require'user.config'.colors.warning })
    vim.api.nvim_set_hl(0, 'Information', { fg =  require'user.config'.colors.information })
    vim.api.nvim_set_hl(0, 'Hint', { fg = require'user.config'.colors.hint })

    -- Treesitter comment notes
    -- TODO(scope):
    -- NOTE(scope):
    -- XXX(scope):
    -- WARNING(scope):
    -- SAFETY(scope):
    -- PERF(scope):
    -- FIXME(scope):
    -- BUG(scope):
    vim.api.nvim_set_hl(0, '@text.note', { link = 'Information', fg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, '@text.warning', { link = 'Warning', fg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, '@text.danger', { link = 'Error', fg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, '@text.todo', { link = 'Hint', fg = 'NONE', ctermbg = 'NONE' })

    -- Diffs
    vim.api.nvim_set_hl(0, 'diffAdded', { fg = require'user.config'.colors.git.added })
    vim.api.nvim_set_hl(0, 'diffChanged', { fg = require'user.config'.colors.git.changed })
    vim.api.nvim_set_hl(0, 'diffDeleted', { fg = require'user.config'.colors.git.deleted })

    -- Gitsigns/Gitgutter
    vim.api.nvim_set_hl(0, 'GitGutterAdd', { link = 'diffAdded' })
    vim.api.nvim_set_hl(0, 'GitGutterChange', { link = 'diffChanged' })
    vim.api.nvim_set_hl(0, 'GitGutterDelete', { link = 'diffDeleted' })
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'diffAdded' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'diffChanged' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'diffDeleted' })
    
    -- Fugitive
    vim.api.nvim_set_hl(0, 'fugitiveUnstagedModifier', { link = 'diffChanged' })
    vim.api.nvim_set_hl(0, 'fugitiveUntrackedModifier', { link = 'diffAdded' })

    -- Search (variants: #1da9f1 #4183c4)
    vim.cmd [[ highlight Search ctermbg=NONE guibg='#4183c4' guifg='#21252b' ]] 
    vim.cmd [[ highlight IncSearch ctermbg=NONE guibg='#ff9e64' guifg='#21252b' ]] 

    -- Diagnostics
    vim.api.nvim_set_hl(0, 'DiagnosticsError', { link = 'Error' })
    vim.api.nvim_set_hl(0, 'DiagnosticsWarning', { link = 'Warning' })
    vim.api.nvim_set_hl(0, 'DiagnosticsInformation', { link = 'Information' })
    vim.api.nvim_set_hl(0, 'DiagnosticsHint', { link = 'Hing' })

    vim.api.nvim_set_hl(0, 'DiagnosticSignError', { link = 'Error' })
    vim.api.nvim_set_hl(0, 'DiagnosticSignWarning', { link = 'Warning' })
    vim.api.nvim_set_hl(0, 'DiagnosticSignInformation', { link = 'Information' })
    vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { link = 'Hint' })

    vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineError', { link = 'Error' })
    vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineWarning', { link = 'Warning' })
    vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineInformation', { link = 'Information' })
    vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineHint', { link = 'Hint' })

    -- For some reason i need to specify this (non lsp variant) for
    -- undercurl to properly work on hints, replacing the default
    -- grey bg cyan text behavior
    -- Also, there seems to be two variants of LspDiagnnostic stuff, with -s, and without.
    -- Only the former (with s) seems to work. Dunno why, this may break later.
    vim.cmd ([[ highlight DiagnosticUnderlineHint cterm=undercurl gui=undercurl guisp='%s' ]]):format(require'user.config'.colors.hint) 
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
    vim.opt_local.wrap = true -- set wrap
    vim.opt_local.shiftwidth = 4 -- ? something with setting spaces/tabs to 4 spaces
    vim.opt_local.tabstop = 4 -- ? something with setting spaces/tabs to 4 spaces
    vim.opt_local.softtabstop = 4 -- ? something with setting spaces/tabs to 4 spaces
    vim.opt_local.spell = true -- enable spellcheck
    vim.opt_local.spelllang = 'en,ru' -- spellcheck languages
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
