-- Lazy.git init file

require("lazy").setup({
  {
    'aserowy/tmux.nvim',
    keys = require'user.utils'.flatten_keys(require('user.plugin.tmux').keys),
    config = require('user.plugin.tmux').setup,
  },

  -- Colorschemes
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
  },

  -- Telescope (generic picker/fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = require'user.utils'.flatten_keys(require('user.plugin.telescope').keys),
    cmd = 'Telescope',
    config = require('user.plugin.telescope').setup,
  },

  -- UI
  {
    'nvim-telescope/telescope-ui-select.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    init = require('user.plugin.telescope-ui-select').init
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    event = "VeryLazy",
    config = require('user.plugin.lualine').setup,
  },
  {
    'nativerv/lualine-wal.nvim',
    lazy = false,
    event = 'VeryLazy',
  },

  -- Editing
  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  }, -- Vimscript
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = require('user.plugin.nvim-surround').setup,
  },
  {
    'fedepujol/move.nvim',
    keys = require'user.utils'.flatten_keys(require('user.plugin.move').keys),
    config = require('user.plugin.move').setup,
  },
  {
    'mg979/vim-visual-multi',
    keys = require'user.utils'.flatten_keys(require('user.plugin.vim-visual-multi').keys),
    config = require('user.plugin.vim-visual-multi').setup,
  }, -- Vimscript
  {
    'numToStr/Comment.nvim',
    keys = require'user.utils'.flatten_keys(require('user.plugin.comment').keys),
    config = require('user.plugin.comment').setup,
  },

  -- Quality of Life
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    tag = 'release',
    config = require('user.plugin.gitsigns').setup,
  },
}, require'user.plugin.lazy'.spec)
