-- Lazy.git init file

require("lazy").setup({
  -- Navigation,
  {
    'phaazon/hop.nvim',
    config = require('user.plugin.hop').setup,
  },
  {
    'bkad/CamelCaseMotion',
    config = require('user.plugin.camel-case-motion').setup(),
  }, -- Vimscript
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
  {
    'RRethy/vim-illuminate',
    -- event = { "BufReadPost", "BufNewFile" },
    event = { "VeryLazy" },
    config = require('user.plugin.illuminate').setup,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 
      { 'kyazdani42/nvim-web-devicons' },  
      {
        'nativerv/lualine-wal.nvim',
        event = 'VeryLazy',
      },
    },
    event = "VeryLazy",
    config = require('user.plugin.lualine').setup,
  },

  -- Editing
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = require('user.plugin.autopairs').setup
  },
  {
    'tpope/vim-repeat',
    keys = '.',
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

  -- Autocompletion - core plugin
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer', -- Source for nvim-cmp - buffer words
      'hrsh7th/cmp-path', -- Source for nvim-cmp - paths
      'hrsh7th/cmp-nvim-lua', -- Source for nvim-cmp - nvim's lua api
    },
    event = 'InsertEnter',
    config = require('user.plugin.cmp').setup,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      {
        'HiPhish/nvim-ts-rainbow2',
        event = 'VeryLazy',
      },
    },
    event = { "BufReadPost", "BufNewFile" },
    -- event = { "UIEnter" },
    config = require('user.plugin.treesitter').setup,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    keys = require'user.utils'.flatten_keys(require('user.plugin.comment').keys),
  }, 
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSNodeUnderCursor' },
  },
  {
    'windwp/nvim-ts-autotag',
    config = require('user.plugin.nvim-ts-autotag').setup,
    ft = {
      'html',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'vue',
      'tsx',
      'jsx',
      'rescript',
      'xml',
      'php',
      'markdown',
      'glimmer',
      'handlebars',
      'hbs',
      'htmldjango',
    },
  },

  -- Quality of Life
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { "BufReadPre", "BufNewFile" },
    -- event = { "UIEnter" },
    tag = 'release',
    config = require('user.plugin.gitsigns').setup,
  },
}, require'user.plugin.lazy'.spec)
