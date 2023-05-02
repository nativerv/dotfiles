-- Lazy.git init file

require("lazy").setup({
  -- Navigation,
  {
    'phaazon/hop.nvim',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.hop').mappings, true),
    config = require('user.plugin.hop').setup,
  },
  {
    'bkad/CamelCaseMotion',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.camel-case-motion').mappings, true),
    config = require('user.plugin.camel-case-motion').setup,
  }, -- Vimscript
  {
    'aserowy/tmux.nvim',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.tmux').mappings, true),
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
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.telescope').mappings, true),
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
    event = { "VeryLazy" },
    config = require('user.plugin.illuminate').setup,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 
      { 'nvim-tree/nvim-web-devicons' },  
      {
        'nativerv/lualine-wal.nvim',
        event = 'VeryLazy',
      },
    },
    event = "VeryLazy",
    config = require('user.plugin.lualine').setup,
  },
  {
    'SmiteshP/nvim-navic',
    event = 'BufEnter',
    config = require('user.plugin.navic').setup,
  },

  -- Editing
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = require('user.plugin.autopairs').setup
  },
  {
    'tpope/vim-repeat',
    keys = { { '.',  desc = 'Repeat last command' } },
  }, -- Vimscript
  {
    'kylechui/nvim-surround',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.nvim-surround').mappings, true),
    config = require('user.plugin.nvim-surround').setup,
  },
  {
    'fedepujol/move.nvim',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.move').mappings, true),
    config = require('user.plugin.move').setup,
  },
  {
    'mg979/vim-visual-multi',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.vim-visual-multi').mappings, true),
    init = require('user.plugin.vim-visual-multi').init,
  }, -- Vimscript
  {
    'numToStr/Comment.nvim',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.comment').mappings, false),
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
      { 'nvim-treesitter/nvim-treesitter-textobjects', },
      { 'HiPhish/nvim-ts-rainbow2' },
    },
    event = { "BufReadPost", "BufNewFile" },
    config = require('user.plugin.treesitter').setup,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.comment').mappings, false),
  }, 
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSNodeUnderCursor', 'TSHighlightCapturesUnderCursor' },
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
    tag = 'release',
    config = require('user.plugin.gitsigns').setup,
  },
  {
    'NvChad/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle', },
    config = require('user.plugin.colorizer').setup,
  },
  {
    'folke/which-key.nvim',
    config = require('user.plugin.which-key').setup,
  },
  {
    'dstein64/nvim-scrollview',
    event = { "VeryLazy" },
    config = require('user.plugin.nvim-scrollview').setup,
  },
  {
    'ghillb/cybu.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.cybu').mappings, true),
    init = require('user.plugin.cybu').init,
    config = require('user.plugin.cybu').setup,
  },
  {
    'chentoast/live.nvim',
  },

  -- Features
  {
    -- NOTE: the classic vimscript variant of neogit
    'tpope/vim-fugitive',
    keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.vim-fugitive').mappings, true),
    cmd = { 'G' },
    config = require('user.plugin.vim-fugitive').setup,
  },
  -- { 
  --  -- NOTE: lua variant of vim-fugitive
  --   'TimUntersberger/neogit', 
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.neogit').mappings, true),
  --   cmd = { 'Neogit' },
  --   config = require('user.plugin.neogit').setup,
  -- },
  -- {
  --   -- NOTE: this plugin caused too much of a hassle and adds too much code
  --   -- into the config for what it does - just shows the git status and diff on
  --   -- files. I can already get that from plugins like `neogit` or `fugitive`,
  --   -- and i can view diff and stage/unstage/reset changes with `gitsigns`
  --   -- (which `diffview` can't even do by itself and staging with `gitsigns` inside
  --   -- it causes it to reset its view and/or go to the next hunk in a random file
  --   -- which is pain in the ass and caused additional problems for me at the time)
  --   -- "diffview.nvim": { "branch": "main", "commit": "f9ddbe798cb92854a383e2377482a49139a52c3d" },
  --   'sindrets/diffview.nvim', 
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   keys = require'user.lib.plugin-management'.extract_keys_from_module_mappings(require('user.plugin.diffview').mappings, true),
  --   cmd = {  
  --     'DiffviewClose',
  --     'DiffviewFileHistory',
  --     'DiffviewFocusFiles',
  --     'DiffviewLog',
  --     'DiffviewOpen',
  --     'DiffviewRefresh',
  --     'DiffviewToggleFiles', 
  --   },
  --   config = require('user.plugin.diffview').setup,
  -- },
}, require'user.plugin.lazy'.spec)
