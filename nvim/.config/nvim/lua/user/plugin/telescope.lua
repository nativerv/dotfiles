local M = {}

M.setup = function()
  local config = {}
  config.extensions = {}
  config.defaults = {
    file_ignore_patterns = {
      '.git',
    },
    -- prompt_prefix = ' ',
    -- prompt_prefix = ' ',
    prompt_prefix = '  ',
  }
  config.pickers = {
    find_files = {
      hidden = true,
      --no_ignore = true,
    },
    live_grep = {
      hidden = true,
      --no_ignore = true,
    },
  }
  config.extensions['ui-select'] = {
    require('telescope.themes').get_dropdown {
      -- even more opts
    },
  }

  -- Setup Telescope with the `config`
  require('telescope').setup(config)

  -- Find files (Ctrl-P)
  vim.keymap.set('n', '<leader>ff', function()
    require('telescope.builtin').find_files { hidden = true }
  end, { desc = 'Find files (ctrl-p)' })
  vim.keymap.set('n', '<C-p>', function()
    require('telescope.builtin').find_files { hidden = true }
  end, { desc = 'Find files' })
  -- The rest junk
  vim.keymap.set('n', '<leader>fb', function()
    require('telescope.builtin').current_buffer_fuzzy_find()
  end, { desc = 'Find in current buffer' })
  vim.keymap.set('n', '<leader>fh', function()
    require('telescope.builtin').help_tags()
  end, { desc = 'Find help page' })
  vim.keymap.set('n', '<leader>ft', function()
    require('telescope.builtin').tags()
  end, { desc = 'Find ctags' })
  vim.keymap.set('n', '<leader>fp', function()
    require('telescope.builtin').live_grep()
  end, { desc = 'Find in files (live grep)' })
  vim.keymap.set('n', '<leader>?', function()
    require('telescope.builtin').oldfiles()
  end, { desc = '' })
  vim.keymap.set('n', '<leader>fd', function()
    require('telescope.builtin').diagnostics()
  end, { desc = 'Find diagnostics' })
end

return M
