-- | Todo: install vim-matchup
-- | Todo: install lsp-status
-- | Todo: install treesitter
-- | Todo: install trouble.nvim
-- | Todo: install barbar.nvim

return require('packer').startup(function()
  -- | Packer
  use 'wbthomason/packer.nvim'

  -- | Color Schemes
  use '~/pr/wal.vim'
  use 'joshdick/onedark.vim'
  use 'morhetz/gruvbox'

  -- | Lsp
  use 'neovim/nvim-lspconfig'     -- | Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp'          -- | Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'      -- | LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'  -- | Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'          -- | Snippets plugin
  use 'nvim-lua/lsp-status.nvim'  -- | Lsp info getters for statuslines
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig'
    }
  }

  -- | Navigation 
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'bkad/CamelCaseMotion'            -- | Vimscript

  -- | Edit
  use 'tpope/vim-surround'              -- | Vimscript (surround.nvim)
  use 'matze/vim-move'                  -- | Vimscript (move.nvim)
  use 'mg979/vim-visual-multi'          -- | Vimscript
  use 'preservim/nerdcommenter'         -- | Vimscript

  -- | Status
  use {
    'shadmansaleh/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true},
    options = { theme = 'pywal' },
  }
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    tag = 'release'
  }
  use 'lukas-reineke/indent-blankline.nvim'

  -- | Quality of Life
  use {
    'windwp/nvim-autopairs',
    as = 'nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }
  use {
    'norcalli/nvim-colorizer.lua',
    as = 'nvim-colorizer',
    config = function()
    end
  }
end)                                    
