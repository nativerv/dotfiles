local undodir_path = vim.loop.os_homedir() .. '/.cache/nvim/undodir'

-- | Outer world
vim.opt.mouse          = 'a'            -- | Ebable mouse
vim.opt.clipboard      = 'unnamedplus'  -- | Use system clipboard
vim.opt.titlestring    = '%F - NeoVim'  -- | Title template
vim.opt.title          = true           -- | Enable title
vim.opt.titleold       = ''             -- | ?

-- | Inner world
vim.g.mapleader        = ' '
vim.g.maplocalleader   = ' '
vim.opt.termguicolors  = true           -- | Truecolor
vim.opt.number         = true           -- | ?
vim.opt.relativenumber = true           -- | Line numbers starting their count from line
vim.opt.smarttab       = true           -- | ?
vim.opt.ignorecase     = true           -- | Search ignorecase
vim.opt.cindent        = true           -- | Autoindent new lines using C rules
vim.opt.cinoptions     = '2'            -- | ?
vim.opt.shiftwidth     = 2              -- | ?
vim.opt.tabstop        = 2              -- | ?
vim.opt.softtabstop    = 2              -- | ?
vim.opt.cursorline     = true           -- | Highlight line
vim.opt.expandtab      = true           -- | Tabs -> Spaces
vim.opt.colorcolumn    = '999999'       -- | 80 columns hint, or disable it (99999 is because of #59 in `lukas-reineke/indent-blankline.nvim`)
vim.opt.wrap           = false          -- | Disable word wrap
vim.opt.autochdir      = false          -- | Automatically cd to buffer's dir
vim.opt.signcolumn     = 'yes:2'        -- | FIX FUCKING GITSIGNS JUMPING BACK AND FORTH
vim.opt.formatoptions  = 'jql'          -- | Formatoptions -= cro - disable auto comment leader insertion
vim.opt.undodir        = undodir_path   -- | Enable persistent undo
vim.opt.undofile       = true           -- | Enable persistent undo

-- | Plugin world
--
-- | nerdcommenter
-- | Disable creation of default mappings
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDSpaceDelims           = 0

-- | camelcasemotion
vim.g.camelcasemotion_key = '<leader>'

-- | vim-move
vim.g.move_key_modifier = 'M-C'

-- | rnvimr
-- | Make Ranger replace Netrw and be the file explorer
vim.g.rnvimr_enable_ex = 1

-- | nvim-code-action-menu
vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_show_diff = true
