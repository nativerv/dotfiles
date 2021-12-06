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

-- | Plugin world

-- | onedark.vim:
-- | Don't set a background color when running in a terminal;
-- | just use the terminal's background color
-- | `gui` is the hex color code used in GUI mode/nvim true-color mode
-- | `cterm` is the color code used in 256-color mode
-- | `cterm16` is the color code used in 16-color mode

vim.cmd [[
  if (has("autocmd") && !has("gui_running"))
    augroup colorset
      autocmd!
      let white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }

      " | `bg` will not be styled since there is no `bg` setting
      autocmd ColorScheme * call onedark#set_highlight(
        \ "Normal",
        \ { "fg": white }
      \ ) 
    augroup END
  endif
]]

vim.g.onedark_color_overrides = {
  cursor_grey = {
    gui = "#2c1a1c",
    --gui = "#3F521B",
    --gui = "#1F290D",
    --gui = "#0F1203",
    cterm = 235,
    cterm16 = 0
  },
}

-- | nerdcommenter
-- | Disable creation of default mappings
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDSpaceDelims           = 0

-- | Set a colorscheme
vim.cmd [[ colorscheme onedark ]]

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
