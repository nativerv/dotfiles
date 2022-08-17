local xdg_cache_home = vim.env.XDG_CACHE_HOME
  or vim.loop.os_homedir() .. '/.cache'
local undodir_path = xdg_cache_home .. '/nvim/undodir'

-- Outer world
vim.opt.mouse          = 'a'            -- Ebable mouse
vim.opt.clipboard      = 'unnamedplus'  -- Use system clipboard
vim.opt.titlestring    = '%t - NeoVim'  -- Title template
vim.opt.title          = true           -- Enable title
vim.opt.titleold       = ''             -- ?

-- Inner world
vim.g.mapleader        = ' '
vim.g.maplocalleader   = ' '
vim.opt.termguicolors  = true           -- Truecolor
vim.opt.number         = true           -- ?
vim.opt.relativenumber = false          -- Line numbers starting their count from line
vim.opt.smarttab       = true           -- ?
vim.opt.ignorecase     = true           -- Search ignorecase
vim.opt.cindent        = true           -- Autoindent new lines using C rules
vim.opt.cinoptions     = '2'            -- ?
vim.opt.shiftwidth     = 2              -- ?
vim.opt.tabstop        = 2              -- ?
vim.opt.softtabstop    = 2              -- ?
vim.opt.cursorline     = true           -- Highlight line
vim.opt.expandtab      = true           -- Tabs -> Spaces
vim.opt.colorcolumn    = '999999'       -- 80 columns hint, or disable it (99999 is because of #59 in `lukas-reineke/indent-blankline.nvim`)
vim.opt.wrap           = false          -- Disable word wrap
vim.opt.linebreak      = true           -- Disable word wrap
vim.opt.autochdir      = false          -- Automatically cd to buffer's dir
vim.opt.signcolumn     = 'yes:2'        -- FIX FUCKING GITSIGNS JUMPING BACK AND FORTH
vim.opt.formatoptions  = vim.opt.formatoptions
  -- The following comments is written by TJ, i'll stick this here
  -- and test how i feel about it for some time
  -- Before: :set 'formatoptions' -> jcroql
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  - "o" -- O and o, don't continue comments
  - "2" -- I'm not in gradeschool anymore
  + "j" -- Auto-remove comments if possible.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "c" -- In general, I like it when comments respect textwidth
  + "r" -- But do continue when pressing enter.
  + "q" -- Allow formatting comments w/ gq
vim.opt.undodir        = undodir_path   -- Enable persistent undo
vim.opt.undofile       = true           -- Enable persistent undo
vim.opt.laststatus     = 3              -- Use only one statusline (without lualine)
vim.g.netrw_browsex_viewer = "cd %:h && xdg-open"

vim.g.compile_tex      = true           -- Compile latex on save by default

-- lsp
vim.lsp.set_log_level('debug')

-- Plugin world
--
-- nerdcommenter
-- Disable creation of default mappings
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDSpaceDelims           = 0

-- camelcasemotion
vim.g.camelcasemotion_key = '<leader>'

-- vim-move
vim.g.move_key_modifier = 'M-C'

-- rnvimr
-- Make Ranger replace Netrw and be the file explorer
vim.g.rnvimr_enable_ex = 1

-- nvim-code-action-menu
vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_show_diff = true
