local undodir_path = vim.fn.stdpath 'state' .. '/undodir'

-- Outer world
vim.opt.mouse = 'a' -- Ebable mouse
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.titlestring = '%t - NeoVim' -- Title template
vim.opt.title = true -- Enable title
vim.opt.titleold = '' -- ?

-- Inner world
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true -- Truecolor
vim.opt.number = true -- Enable line numbers
vim.opt.relativenumber = false -- Relative line numbers (origin is always at current line)
vim.opt.smarttab = true -- ?
vim.opt.ignorecase = true -- Search ignorecase
vim.opt.cindent = false -- Autoindent new lines using C rules
vim.opt.cinoptions = '2' -- ?
vim.opt.shiftwidth = 2 -- ? something with setting spaces/tabs to 2 spaces
vim.opt.tabstop = 2 -- ? something with setting spaces/tabs to 2 spaces
vim.opt.softtabstop = 2 -- ?
vim.opt.cursorline = true -- Highlight line
vim.opt.expandtab = true -- Tabs -> Spaces
vim.opt.colorcolumn = '999999' -- 80 columns hint, or disable it (99999 is because of #59 in `lukas-reineke/indent-blankline.nvim`)
vim.opt.wrap = false -- Disable word wrap
vim.opt.linebreak = true -- Disable word wrap
vim.opt.autochdir = false -- Automatically cd to buffer's dir
vim.opt.signcolumn = 'yes:2' -- FIX FUCKING GITSIGNS JUMPING BACK AND FORTH
vim.opt.undodir = undodir_path -- Enable persistent undo
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undolevels = 10000 -- Keep more undos
vim.opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete
vim.opt.laststatus = 3 -- Use only one statusline (without lualine)
vim.opt.shortmess:append 'I' -- Disable welcome message
vim.g.netrw_browsex_viewer = 'cd %:h && xdg-open'
vim.o.conceallevel = 2
vim.o.scrolloff = 8

vim.g.compile_tex = true -- Compile latex on save by default (i have autocmds for that)

-- vim.g.loaded_netrw = 1
