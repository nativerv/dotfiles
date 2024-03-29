-- TODO: write a plugin that runs curls
-- TODO: look at how vim-illuminate handles treesitter & lsp support
-- TODO: maybe refactor 'user.plugin.lspconfig' exporting on_attach and stuff with LspAttach autocmd

return require('packer').startup {
  config = {
    snapshot_path = vim.fn.stdpath 'config' .. '/snapshots',
  },
  function(use)
    -- Packer
    use {
      'wbthomason/packer.nvim',
      config = function()
        require('user.plugin.packer').setup()
      end,
    }

    -- Performance
    use { 'lewis6991/impatient.nvim' }
    use {
      'antoinemadec/FixCursorHold.nvim',
      config = function()
        require('user.plugin.fixcursorhold').setup()
      end,
      commit = '1bfb32e7ba1344925ad815cb0d7f901dbc0ff7c1',
    }

    -- Status
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('user.plugin.lualine').setup()
      end,
    }
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      tag = 'release',
      config = function()
        require('user.plugin.gitsigns').setup()
      end,
    }

    -- Docs
    use {
      'milisims/nvim-luaref',
      commit = '9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127',
    }

    -- Color Schemes
    use { 'ful1e5/onedark.nvim' }
    use { 'folke/tokyonight.nvim' }
    use { '~/pr/lualine-wal.nvim' }

    -- Visuals
    use {
      'kyazdani42/nvim-web-devicons',
      commit = '09e62319974d7d7ec7e53b974724f7942470ef78',
    }

    -- Editing
    use {
      'tpope/vim-repeat',
      commit = '24afe922e6a05891756ecf331f39a1f6743d3d5a',
    } -- Vimscript
    -- use {
    --   'tpope/vim-surround',
    --   config = function()
    --     require('user.plugin.vim-surround').setup()
    --   end,
    -- } -- Vimscript (surround.nvim)
    use {
      'kylechui/nvim-surround',
      config = function()
        require('user.plugin.nvim-surround').setup()
      end,
    }
    use {
      'matze/vim-move',
      commit = '97fc86064eaa95384b5b00f6253e339fba44da5d',
    } -- Vimscript (move.nvim)
    use {
      'mg979/vim-visual-multi',
      config = function()
        require('user.plugin.vim-visual-multi').setup()
      end,
      commit = '724bd53adfbaf32e129b001658b45d4c5c29ca1a',
    } -- Vimscript
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('user.plugin.comment').setup()
      end,
    }

    -- Snippets plugin
    use { 'L3MON4D3/LuaSnip' }

    -- Autocompletion - core plugin
    use {
      'hrsh7th/nvim-cmp',
      config = function()
        require('user.plugin.cmp').setup()
      end,
    }
    -- Source for nvim-cmp - buffer words
    use {
      'hrsh7th/cmp-buffer',
    }
    -- Source for nvim-cmp - paths
    use {
      'hrsh7th/cmp-path',
    }
    -- Source for nvim-cmp - nvim's lua api
    use {
      'hrsh7th/cmp-nvim-lua',
    }
    -- Source for nvim-cmp - luasnip
    use {
      'saadparwaiz1/cmp_luasnip',
    }
    -- Source for nvim-cmp - lsp
    use {
      'hrsh7th/cmp-nvim-lsp',
      after = { 'nvim-lspconfig' },
      config = function()
        require('user.plugin.cmp-nvim-lsp').setup()
      end,
      commit = 'ebdfc204afb87f15ce3d3d3f5df0b8181443b5ba',
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('user.plugin.treesitter').setup()
      end,
    }
    use {
      'JoosepAlviste/nvim-ts-context-commentstring',
      requires = 'nvim-treesitter/nvim-treesitter',
    }
    use { 'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter/nvim-treesitter' }
    use {
      'nvim-treesitter/playground',
      requires = 'nvim-treesitter/nvim-treesitter',
    }
    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = 'nvim-treesitter/nvim-treesitter',
    }
    use {
      'windwp/nvim-ts-autotag',
      requires = 'nvim-treesitter/nvim-treesitter',
      config = function()
        require('nvim-treesitter.configs').setup {
          autotag = {
            enable = true,
          },
          enable_rename = false,
        }
      end,
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
      commit = 'fdefe46c6807441460f11f11a167a2baf8e4534b',
    }

    -- LSP -- Language Server Protocol
    use {
      'neovim/nvim-lspconfig',
      after = { 'neodev.nvim' },
      config = function()
        require('user.plugin.lspconfig').setup()
      end,
    }
    use {
      'folke/neodev.nvim',
      config = function()
        require('user.plugin.neodev').setup()
      end,
    }
    use {
      '~/pr/dressing.nvim',
      config = function()
        require('user.plugin.dressing').setup()
      end,
    }
    use { -- Display kind in nvim-cmp
      'onsails/lspkind-nvim',
      commit = '93e98a0c900327ce7e9be1cbf24aebbe7170e375',
    }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      after = { 'nvim-lspconfig' },
      config = function()
        require('user.plugin.null-ls').setup()
      end,
    }
    use {
      'SmiteshP/nvim-navic',
      after = { 'nvim-lspconfig' },
      config = function()
        require('user.plugin.navic').setup()
      end,
      -- frequent updates
      commit = '7a2b823152fe4de65ee7925b0e32d26ed73bc57c',
    }
    use {
      'RRethy/vim-illuminate',
      config = function()
        require('user.plugin.illuminate').setup()
      end,
    }
    use {
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
      config = function()
        require('user.plugin.lsp-lines').setup()
      end,
      commit = 'ec98b45c8280e5ef8c84028d4f38aa447276c002',
    }
    use {
      'lvimuser/lsp-inlayhints.nvim',
      config = function()
        require('user.plugin.lsp-inlayhints').setup()
      end,
      commit = 'a28c51a6362e3faa17f67749436cb5c8b55dcc6d',
    }
    use {
      'zbirenbaum/neodim',
      event = 'LspAttach',
      config = function()
        require('user.plugin.neodim').setup()
      end,
      commit = 'c346344ade2ce709e6bd282f10e43778672b861e',
    }
    use {
      'j-hui/fidget.nvim',
      -- event = 'LspAttach',
      config = function()
        require('user.plugin.fidget').setup()
      end,
      commit = '44585a0c0085765195e6961c15529ba6c5a2a13b',
    }
    use {
      'lspcontainers/lspcontainers.nvim',
      after = { 'nvim-lspconfig' },
      setup = function()
        require('user.plugin.lspcontainers').setup()
      end,
    }

    -- Syntax highlighing plugins
    use {
      'kmonad/kmonad-vim',
      commit = '994e2a1f81cf03c740f0bfdd75fd332ee8fafbdd',
    } -- Vimscript

    -- Features
    use { 'tpope/vim-fugitive' }
    --use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim' } }
    -- use {
    --   'NTBBloodbath/rest.nvim',
    --   requires = { 'nvim-lua/plenary.nvim' },
    --   config = function()
    --     require('user.plugin.rest').setup()
    --   end,
    --   commit = '2826f6960fbd9adb1da9ff0d008aa2819d2d06b3',
    -- }
    --use { 'mfussenegger/nvim-dap' }
    use {
      'luukvbaal/nnn.nvim',
      config = function()
        require('user.plugin.nnn').setup()
      end,
      commit = '6b048ba5ccab93d05ca77e1b405fef1f74f4bb27',
    }
    use {
      'dstein64/vim-startuptime',
      commit = '61f122ebc41e9bcf1793c752a728db59feee77bb',
      cmd = { 'StartupTime' },
    }
    use {
      'folke/todo-comments.nvim',
      config = function()
        require('user.plugin.todo-comments').setup()
      end,
    }
    -- use {
    --   'vimwiki/vimwiki',
    --   config = function ()
    --     require'user.plugin.vimwiki'.setup()
    --   end,
    --   disable = true,
    --   commit = '63af6e72dd3fa840bffb3ebcb8c96970c02e0913',
    -- }
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function()
        require('user.plugin.markdown-preview').setup()
      end,
      ft = { 'markdown' },
      commit = '02cc3874738bc0f86e4b91f09b8a0ac88aef8e96',
    }
    use {
      'seandewar/killersheep.nvim',
      commit = '506823c47b854df02e78d5fec9468ab0e542dcf5',
    }
    use {
      'mbbill/undotree',
      setup = function()
        require('user.plugin.undotree').setup()
      end,
      commit = '1a23ea84bd02c34f50d8e10a8b4bfc89597ffe4e',
    }

    -- Navigation
    use {
      'phaazon/hop.nvim',
      config = function()
        require('user.plugin.hop').setup()
      end,
      commit = 'e2f978b50c2bd9ae2c6a4ebdf2222c0f299c85c3',
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('user.plugin.telescope').setup()
      end,
    }
    use {
      'nvim-telescope/telescope-ui-select.nvim',
      requires = 'nvim-telescope/telescope.nvim',
      config = function()
        require('user.plugin.telescope-ui-select').setup()
      end,
    }
    use {
      'bkad/CamelCaseMotion',
      config = function()
        require('user.plugin.camel-case-motion').setup()
      end,
      commit = 'de439d7c06cffd0839a29045a103fe4b44b15cdc',
    } -- Vimscript
    use {
      'aserowy/tmux.nvim',
      config = function()
        require('user.plugin.tmux').setup()
      end,
      commit = '2535a67a78da737207c918106cade1ba016d9f6a',
    }

    -- Quality of Life
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('user.plugin.autopairs').setup()
      end,
      commit = '14cc2a4fc6243152ba085cc2059834113496c60a',
    }
    use {
      'NvChad/nvim-colorizer.lua',
      config = function()
        require('user.plugin.colorizer').setup()
      end,
      commit = '36c610a9717cc9ec426a07c8e6bf3b3abcb139d6',
    }
    use {
      'powerman/vim-plugin-ruscmd',
      commit = 'e952abbea092e420b128936a0c284fb522612c3a',
    }
    use {
      'folke/which-key.nvim',
      config = function()
        require('user.plugin.which-key').setup()
      end,
      commit = '6885b669523ff4238de99a7c653d47b081b5506d',
    }
    use {
      'dstein64/nvim-scrollview',
      commit = '25c23219db8b2b932a595b4d2b661406ce4459fe',
    }
    use {
      'ojroques/nvim-bufdel',
      commit = 'af537a915b8c60c6dcb6416e0e9382a5bed94bb3',
    }
    use {
      'ghillb/cybu.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
      config = function()
        require('user.plugin.cybu').setup()
      end,
      commit = '395791b1e1177e3459c85415970ab8216b19a5dc',
    }
    --use { 'lukas-reineke/indent-blankline.nvim' }
  end,
}
