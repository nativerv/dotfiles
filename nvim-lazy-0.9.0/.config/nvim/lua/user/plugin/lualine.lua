local M = {}

M.setup = function()
  -- Autocmd - Refresh `lualine`'s `pywal` theme on SIGUSR1 (`setwall` sends it)
  vim.api.nvim_create_autocmd({ 'Signal' }, {
    pattern = 'SIGUSR1',
    group = vim.api.nvim_create_augroup(
      'nrv#lualine_sigusr1_refresh_wal_theme',
      { clear = true }
    ),
    callback = function()
      require 'lualine'.setup {}
    end,
  })
  
  -- Setup lualine
  require 'lualine'.setup {
    options = {
      theme = 'wal',
      globalstatus = true,
    },
    extensions = { 'lazy' },
    sections = {
      lualine_c = {
        "os.data('%a')",
        'data',
        -- | TODO: figure out what to do with this unused plugin, delete it or properly integrate
        -- | Search for lsp-status and lsp_status
        --require'lsp-status'.status,
      },
      lualine_b = {
        {
          'branch'
        },
        {
          'diff',
          colored = true, -- Displays a colored diff status if set to true
          diff_color = {
            -- Same color values as the general color option can be used here.
            added    = { fg = require'user.config'.colors.git.added, },
            modified = { fg = require'user.config'.colors.git.changed, },
            removed  = { fg = require'user.config'.colors.git.deleted, },
          },
          symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
          -- A function that works as a data source for diff.
          -- It must return a table as such:
          --   { added = add_count, modified = modified_count, removed = removed_count }
          -- or nil on failure. count <= 0 won't be displayed.
          source = nil,
        },
        {
          'diagnostics',
          diagnostics_color = {
            error = { fg = require 'user.config'.colors.error, }, -- Changes diagnostics' error color, without touching theme's bgcolor.
            warn  = { fg = require 'user.config'.colors.warning, }, -- Changes diagnostics' warn color.
            info  = { fg = require 'user.config'.colors.information, }, -- Changes diagnostics' info color.
            hint  = { fg = require 'user.config'.colors.hint, }, -- Changes diagnostics' hint color.
          },
        },
      },
    },
  }
end

return M
