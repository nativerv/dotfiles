---@diagnostic disable: undefined-global

-- | Todo: install vim-matchup
-- | Todo: install lsp-status
-- | Todo: install treesitter
-- | Todo: install trouble.nvim
-- | Todo: install barbar.nvim

return require'packer'.startup(function()
  -- | Packer
  use 'wbthomason/packer.nvim'

  -- | Color Schemes
  use 'joshdick/onedark.vim'
  --use 'navarasu/onedark.nvim'
  use 'morhetz/gruvbox'

  -- | Editing
  use 'tpope/vim-surround'        -- | Vimscript (surround.nvim)
  use 'matze/vim-move'            -- | Vimscript (move.nvim)
  use 'mg979/vim-visual-multi'    -- | Vimscript
  --use 'preservim/nerdcommenter'   -- | Vimscript
  use {
    'numToStr/Comment.nvim',
    --as = 'comment'
  }

  use 'L3MON4D3/LuaSnip'          -- | Snippets plugin
  use 'hrsh7th/nvim-cmp'          -- | Autocompletion  core plugin
  use 'hrsh7th/cmp-buffer'        -- | Buffer word     source for nvim-cmp
  use 'hrsh7th/cmp-path'          -- | Path            source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lua'      -- | Nvim lua config source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'  -- | Snippet         source for nvim-cmp

  -- | Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'nvim-treesitter/playground'

  -- | Language Server Protocol
  use 'neovim/nvim-lspconfig'     -- | Collection of configurations for
                                  -- | built-in LSP client
  use {
    'tami5/lspsaga.nvim',
    config = function ()
      --vim.api.nvim_buf_set_keymap(buffer, 'n', '<F2>', '<cmd>lua require("lspsaga.rename").rename()<cr>', { noremap = true, silent = true })
      --vim.api.nvim_buf_set_keymap(buffer, 'n', '<F2>', '<cmd>lua require("lspsaga.rename").rename()<cr>', { noremap = true, silent = true })
    end
  }
  use {
   'weilbith/nvim-code-action-menu',
   --cmd = 'CodeActionMenu',
  }
  use 'ray-x/lsp_signature.nvim'
  use 'hrsh7th/cmp-nvim-lsp'      -- | LSP source for nvim-cmp
  use 'onsails/lspkind-nvim'      -- | Display kind in nvim-cmp
  use 'nvim-lua/lsp-status.nvim'  -- | LSP info getters for statuslines
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig'
    }
  }

  -- | Language-Specific Plugins
  use {
    'simrat39/rust-tools.nvim',
    requires = {
     'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'
    }
  }

  -- | Features
  use 'kristijanhusak/orgmode.nvim'
  use 'akinsho/org-bullets.nvim'
  use 'tpope/vim-fugitive'
  use {
    'NTBBloodbath/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'kevinhwang91/rnvimr'

  -- | Syntax
  use 'tikhomirov/vim-glsl' -- | Vimscript

  -- | Navigation
  use {
    'phaazon/hop.nvim',
    as = 'hop',
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'bkad/CamelCaseMotion'    -- | Vimscript

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
  use 'aserowy/tmux.nvim'

  -- | Quality of Life
  use {
    'windwp/nvim-autopairs',
    as = 'nvim-autopairs',
    config = function()
      require'nvim-autopairs'.setup()
    end,
  }
  use {
    'norcalli/nvim-colorizer.lua',
    as = 'nvim-colorizer',
    config = function()
    end
  }
  use 'powerman/vim-plugin-ruscmd'
  use 'luukvbaal/stabilize.nvim'
  use 'folke/which-key.nvim'
  use 'dstein64/nvim-scrollview'
  use 'ojroques/nvim-bufdel'

  -- | print(vim.tbl_count(vim.tbl_filter(function(window)
  -- |     return vim.api.nvim_win_get_config(window).relative == ""
  -- |   end,
  -- |   vim.api.nvim_list_wins()
  -- | )))

end)
