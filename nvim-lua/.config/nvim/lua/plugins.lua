-- | Todo: install vim-matchup
-- | Todo: install nvim-lspconfig
-- | Todo: install lsp-status
-- | Todo: install treesitter

return require('packer').startup(function()
  -- | Packer
  use 'wbthomason/packer.nvim'

  -- | Color Schemes
  use '~/pr/wal.vim'
  use 'joshdick/onedark.vim'
  use 'morhetz/gruvbox'

  -- | Quality of Life
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use {
    'windwp/nvim-autopairs',
    as = 'nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'norcalli/nvim-colorizer.lua',
    as = 'nvim-colorizer',
    config = function()
    end
  }
  use {
    'shadmansaleh/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true},
    options = { theme = 'pywal' },
  }
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'lukas-reineke/indent-blankline.nvim'

  use 'tpope/vim-surround'              -- | Vimscript (surround.nvim)
  use 'matze/vim-move'                  -- | Vimscript (move.nvim)
  use 'mg979/vim-visual-multi'          -- | Vimscript
  use 'bkad/CamelCaseMotion'            -- | Vimscript
  --use 'vim-airline/vim-airline'         -- | Vimscript (surround.nvim)
  --use 'vim-airline/vim-airline-themes'  -- | Vimscript (move.nvim)
  use 'preservim/nerdcommenter'         -- | Vimscript
  use 'airblade/vim-gitgutter'          -- | Vimscript
end)                                    
