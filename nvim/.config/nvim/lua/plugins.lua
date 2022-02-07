-- | Todo: install vim-matchup
-- | Todo: install lsp-status
-- | Todo: install treesitter
-- | Todo: install trouble.nvim
-- | Todo: install barbar.nvim

return require'packer'.startup(function(use)
  -- | Packer
  use { 'wbthomason/packer.nvim' }

  -- | Color Schemes
  use { 'ful1e5/onedark.nvim' }
  use { 'ellisonleao/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } }
  use { 'folke/tokyonight.nvim' }
  use { '~/pr/lualine-wal.nvim' }

  -- | Editing
  use { 'tpope/vim-surround' }        -- | Vimscript (surround.nvim)
  use { 'matze/vim-move' }            -- | Vimscript (move.nvim)
  use { 'mg979/vim-visual-multi' }    -- | Vimscript
  use { 'numToStr/Comment.nvim', }

  use { 'hrsh7th/nvim-cmp' }          -- | Autocompletion....core plugin
  use { 'hrsh7th/cmp-buffer' }        -- | Buffer word.......source for nvim-cmp
  use { 'hrsh7th/cmp-path' }          -- | Path..............source for nvim-cmp
  use { 'hrsh7th/cmp-nvim-lua' }      -- | Nvim lua config...source for nvim-cmp
  use { 'L3MON4D3/LuaSnip' }          -- | Snippets..........snippets plugin
  use { 'saadparwaiz1/cmp_luasnip' }  -- | Snippets..........source for nvim-cmp

  -- | Treesitter
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'nvim-treesitter/playground' }

  -- | Language Server Protocol
  use { 'neovim/nvim-lspconfig' }     -- | Collection of configurations for
  --                                  -- | built-in LSP client
  use { 'tami5/lspsaga.nvim', }
  use { 'ray-x/lsp_signature.nvim' }
  use { 'hrsh7th/cmp-nvim-lsp' }      -- | LSP source for nvim-cmp
  use { 'onsails/lspkind-nvim' }      -- | Display kind in nvim-cmp
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig'
    }
  }
  use { 'folke/lsp-colors.nvim', }

  -- | Language-Specific Plugins
  use {
    'simrat39/rust-tools.nvim',
    requires = {
     'nvim-lua/popup.nvim',
     'nvim-lua/plenary.nvim'
    }
  }

  -- | Features
  use { 'kristijanhusak/orgmode.nvim' }
  use { 'tpope/vim-fugitive' }
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use { 'NTBBloodbath/rest.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'kevinhwang91/rnvimr'
  use 'mfussenegger/nvim-dap'

  -- | Navigation
  use { 'phaazon/hop.nvim', as = 'hop', }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'bkad/CamelCaseMotion'    -- | Vimscript
  use 'aserowy/tmux.nvim'

  -- | Status
  use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons', }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', }, }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, tag = 'release' }

  -- | Quality of Life
  use { 'windwp/nvim-autopairs'  }
  use { 'norcalli/nvim-colorizer.lua', }
  use { 'powerman/vim-plugin-ruscmd' }
  use { 'luukvbaal/stabilize.nvim' }
  use { 'folke/which-key.nvim' }
  use { 'dstein64/nvim-scrollview' }
  use { 'ojroques/nvim-bufdel' }
  use { 'lukas-reineke/indent-blankline.nvim' }
end)
