-- | Todo: install lsp-status
-- | Todo: install trouble.nvim
-- | Todo: install barbar.nvim

return require'packer'.startup(function (use)
  -- | Packer
  use { 'wbthomason/packer.nvim' }

  -- Performance
  use { 'lewis6991/impatient.nvim', }
  use {
    'nathom/filetype.nvim',
    config = function ()
      require("filetype").setup {
        overrides = {
          extensions = {
            service = "systemd",
            target  = "systemd",
            timer   = "systemd",
            slice   = "systemd",
            profile = "firejail",
            ['local']   = "firejail",
          },
        },
      }
    end,
  }
  use {
    "antoinemadec/FixCursorHold.nvim",
    config = function ()
      vim.g.curshold_updatime = 1000
    end,
    commit = '1bfb32e7ba1344925ad815cb0d7f901dbc0ff7c1',
  }

  -- Docs
  use {
    "milisims/nvim-luaref",
    commit = '9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127',
  }

  -- | Color Schemes
  use { 'ful1e5/onedark.nvim' }
  --use { 'ellisonleao/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } }
  --use { 'folke/tokyonight.nvim' }
  use { '~/pr/lualine-wal.nvim' }

  -- | Visuals
  --
  use { 'kyazdani42/nvim-web-devicons', commit = '09e62319974d7d7ec7e53b974724f7942470ef78', }

  -- | Editing
  use { 'tpope/vim-repeat', commit = '24afe922e6a05891756ecf331f39a1f6743d3d5a' }          -- | Vimscript (surround.nvim)
  use { 'tpope/vim-surround' }        -- | Vimscript (surround.nvim)
  use { 'matze/vim-move', commit = '97fc86064eaa95384b5b00f6253e339fba44da5d' }            -- | Vimscript (move.nvim)
  use { 'mg979/vim-visual-multi' }    -- | Vimscript
  use { 'numToStr/Comment.nvim', }

  use { 'hrsh7th/nvim-cmp' }          -- | Autocompletion....core plugin
  use { 'hrsh7th/cmp-buffer' }        -- | Buffer word.......source for nvim-cmp
  use { 'hrsh7th/cmp-path' }          -- | Path..............source for nvim-cmp
  use { 'hrsh7th/cmp-nvim-lua' }      -- | Nvim lua config...source for nvim-cmp
  use { 'L3MON4D3/LuaSnip' }          -- | Snippets..........snippets plugin
  use { 'saadparwaiz1/cmp_luasnip' }  -- | Snippets..........source for nvim-cmp

  -- | Treesitter
  use { 'nvim-treesitter/nvim-treesitter', }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', }
  use { 'p00f/nvim-ts-rainbow', }
  use { 'nvim-treesitter/playground', }

  -- | Language Server Protocol
  use { 'neovim/nvim-lspconfig' }     -- | Collection of configurations for
  --                                  -- | built-in LSP client
  use {
    '~/pr/dressing.nvim',
    config = function ()
      require'dressing'.setup {
        input = {
          insert_only = false,
        },
      }
    end
  }
  -- | use { 'ray-x/lsp_signature.nvim' }
  use { 'hrsh7th/cmp-nvim-lsp', commit = 'ebdfc204afb87f15ce3d3d3f5df0b8181443b5ba', }      -- | LSP source for nvim-cmp
  use { 'onsails/lspkind-nvim', commit = '93e98a0c900327ce7e9be1cbf24aebbe7170e375', }      -- | Display kind in nvim-cmp
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  }
  --use { 'folke/lsp-colors.nvim', }

  -- | Language-Specific Plugins
  --use {
  --  'simrat39/rust-tools.nvim',
  --  requires = {
  --   'nvim-lua/popup.nvim',
  --   'nvim-lua/plenary.nvim'
  --  }
  --}

  -- | Syntax highlighing plugins
  use { 'kmonad/kmonad-vim', commit = '994e2a1f81cf03c740f0bfdd75fd332ee8fafbdd' } -- | Vimscript

  -- | Features
  -- use { 'kristijanhusak/orgmode.nvim' }
  use { 'tpope/vim-fugitive' }
  --use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim' } }
  use {
    'NTBBloodbath/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    commit = '2826f6960fbd9adb1da9ff0d008aa2819d2d06b3'
  }
  --use { 'mfussenegger/nvim-dap' }
  use { 'luukvbaal/nnn.nvim' }
  use {
    'dstein64/vim-startuptime',
    commit = '61f122ebc41e9bcf1793c752a728db59feee77bb',
    cmd = { 'StartupTime', },
  }

  -- | Navigation
  use { 'phaazon/hop.nvim', as = 'hop', commit = 'e2f978b50c2bd9ae2c6a4ebdf2222c0f299c85c3' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'bkad/CamelCaseMotion', commit = 'de439d7c06cffd0839a29045a103fe4b44b15cdc', }    -- | Vimscript
  use { 'aserowy/tmux.nvim', commit = '2535a67a78da737207c918106cade1ba016d9f6a', }

  -- | Status
  use { 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons', }, }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', },
    config = function ()
    end
  }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim', }, tag = 'release' }

  -- | Quality of Life
  use { 'windwp/nvim-autopairs'  }
  use { 'norcalli/nvim-colorizer.lua', commit = '36c610a9717cc9ec426a07c8e6bf3b3abcb139d6' }
  use { 'powerman/vim-plugin-ruscmd', commit = 'e952abbea092e420b128936a0c284fb522612c3a' }
  --use { 'luukvbaal/stabilize.nvim' }
  use { 'folke/which-key.nvim' }
  use { 'dstein64/nvim-scrollview' }
  use { 'ojroques/nvim-bufdel', commit = 'af537a915b8c60c6dcb6416e0e9382a5bed94bb3' }
  --use { 'lukas-reineke/indent-blankline.nvim' }
end)
