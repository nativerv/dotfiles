-- | Outer world 
vim.opt.mouse          = 'a'            -- | Ebable mouse
vim.opt.clipboard      = 'unnamedplus'  -- | Use system clipboard
vim.opt.titlestring    = '%F - NeoVim'  -- | Title template
vim.opt.title          = true           -- | Enable title
vim.opt.titleold       = ''             -- | ?

-- | Inner world
vim.g.mapleader = ' '

vim.opt.termguicolors  = true           -- | Truecolor
vim.opt.number         = true           -- | ?
vim.opt.relativenumber = true           -- | Line numbers starting their count from line
vim.opt.smarttab       = true           -- | ?
vim.opt.ignorecase     = true           -- | Search ignorecase
vim.opt.cindent        = true           -- | Autoindent new lines using C rules
vim.opt.tabstop        = 2              -- | ?
vim.opt.shiftwidth     = 2              -- | ?
vim.opt.cursorline     = true           -- | Highlight line
vim.opt.expandtab      = true           -- | Tabs -> Spaces         
vim.opt.colorcolumn    = '80'           -- | Tabs -> Spaces         
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,!"№%?;!@#%&,Ж;:,\\;;$'

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
    cterm = 235,
    cterm16 = 0
  },
}

-- | nerdcommenter
-- | Disable creation of default mappings
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDSpaceDelims           = 0

-- | vim-airline
-- | Enable wal theme to match system look'n'feel
--vim.g.airline_theme = 'wal'

vim.cmd [[ colorscheme onedark ]]

vim.cmd [[
  " Refresh `wal` theme on SIGUSR1
  autocmd Signal SIGUSR1 call RefreshWalTheme()
  function RefreshWalTheme()
    source ~/.cache/wal/colors-wal.vim
    :AirlineTheme wal 
    :redraw
  endfunction
]]

-- | camelcasemotion
vim.g.camelcasemotion_key = '<leader>'
