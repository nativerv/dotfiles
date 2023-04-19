local M = {}

M.setup = function()
  require('illuminate').configure {
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    -- delay: delay in milliseconds
    delay = 120,
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
      'dirvish',
      'fugitive',
      'alpha',
      'NvimTree',
      'packer',
      'neogitstatus',
      'Trouble',
      'lir',
      'Outline',
      'spectre_panel',
      'toggleterm',
      'DressingSelect',
      'TelescopePrompt',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
    modes_allowlist = {},
    large_file_cutoff = 5000,
    large_file_overrides = nil,
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
  }

  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    group = vim.api.nvim_create_augroup(
      'nrv#illuminate_set_highlights',
      { clear = true }
    ),
    callback = function()
      -- Set illuminate colors to be slightly lightened CursorLine color
      local cursor_line_color = vim.api.nvim_get_hl_by_name('CursorLine', true)
      local illuminate_color =
        require('user.lib.colors').lighten(cursor_line_color.background, 1.3, 0x000000)
      vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg =  'NONE'})
      vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = illuminate_color })
      vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = illuminate_color })
    end,
  })
end

return M
