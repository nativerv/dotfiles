local M = {}

M.setup = function()
  local config = {}
  config.extensions = {}
  config.defaults = {
    file_ignore_patterns = {
      -- Be careful as it's a regex pattern!
      -- Got cught on plaing '.git' pattern
      -- Ignoring fugitive and gitsigns
      [[^\.git$]],
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

  -- Find files (Ctrl-P) - dynamically chooses git files or all files
  -- depending on whether you're in a git repo
  vim.keymap.set('n', '<C-p>', function()
    if require('user.utils').is_inside_git_worktree() then
      require('telescope.builtin').git_files {}
    else
      require('telescope.builtin').find_files { hidden = true }
    end
  end, { desc = 'Find files' })

  vim.keymap.set('n', '<leader>ff', function()
    require('telescope.builtin').find_files { hidden = true }
  end, { desc = 'Find files (ctrl-p)' })

  vim.keymap.set('n', '<leader>fg', function()
    require('telescope.builtin').git_files {}
  end, { desc = 'Find files, but only git-managed' })

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

  vim.keymap.set('n', '<leader>f?', function()
    require('telescope.builtin').oldfiles()
  end, { desc = 'Recent files' })

  vim.keymap.set('n', '<leader>f.', function()
    require('telescope.builtin').resume()
  end, { desc = 'Resume last' })

  vim.keymap.set('n', '<leader>fd', function()
    require('telescope.builtin').diagnostics()
  end, { desc = 'Find diagnostics' })
end

return M
