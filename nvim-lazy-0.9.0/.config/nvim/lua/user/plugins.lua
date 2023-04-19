-- Lazy.git init file

require("lazy").setup({
  {
    'aserowy/tmux.nvim',
    keys = require'user.utils'.flatten_keys(require('user.plugin.tmux').keys),
    config = require('user.plugin.tmux').setup,
  },

  -- Telescope (generic picker/fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = require'user.utils'.flatten_keys(require('user.plugin.telescope').keys),
    cmd = 'Telescope',
    config = require('user.plugin.telescope').setup,
  },
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

  -- Quality of Life
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    tag = 'release',
    config = require('user.plugin.gitsigns').setup,
  },
}, require'user.plugin.lazy'.spec)
