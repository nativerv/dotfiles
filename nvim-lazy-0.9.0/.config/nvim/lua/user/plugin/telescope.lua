local M = {}

M.keys = {
  find_files_smart = { '<C-p>' },
  find_files = { '<leader>ff' },
  find_git_files = { '<leader>fg' },
  find_in_buffer = { '<leader>fb' },
  find_help = { '<leader>fh' },
  find_ctags = { '<leader>ft' },
  find_in_files = { '<leader>fp' },
  recent_files = { '<leader>f?' },
  resume_last = { '<leader>f.' },
  find_diagnostics = { '<leader>fd' },
}

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
  require'user.utils'.map_keys('n', M.keys.find_files_smart, function()
    if require('user.utils').is_inside_git_worktree() then
      require('telescope.builtin').git_files {}
    else
      require('telescope.builtin').find_files { hidden = true }
    end
  end, { desc = 'Find files' })

  require'user.utils'.map_keys('n', M.keys.find_files, function()
    require('telescope.builtin').find_files { hidden = true }
  end, { desc = 'Find files (ctrl-p)' })

  require'user.utils'.map_keys('n', M.keys.find_git_files, function()
    require('telescope.builtin').git_files {}
  end, { desc = 'Find files, but only git-managed' })

  -- The rest junk
  require'user.utils'.map_keys('n', M.keys.find_in_buffer, function()
    require('telescope.builtin').current_buffer_fuzzy_find()
  end, { desc = 'Find in current buffer' })

  require'user.utils'.map_keys('n', M.keys.find_help, function()
    require('telescope.builtin').help_tags()
  end, { desc = 'Find help page' })

  require'user.utils'.map_keys('n', M.keys.find_ctags, function()
    require('telescope.builtin').tags()
  end, { desc = 'Find ctags' })

  require'user.utils'.map_keys('n', M.keys.find_in_files, function()
    require('telescope.builtin').live_grep()
  end, { desc = 'Find in files (live grep)' })

  require'user.utils'.map_keys('n', M.keys.recent_files, function()
    require('telescope.builtin').oldfiles()
  end, { desc = 'Recent files' })

  require'user.utils'.map_keys('n', M.keys.resume_last, function()
    require('telescope.builtin').resume()
  end, { desc = 'Resume last' })

  require'user.utils'.map_keys('n', M.keys.find_diagnostics, function()
    require('telescope.builtin').diagnostics()
  end, { desc = 'Find diagnostics' })
end

return M
