local M = {}

M.mappings = {
  -- Find files (Ctrl-P) - dynamically chooses git files or all files
  -- depending on whether you're in a git repo
  find_files_smart = {
    keys = { '<C-p>' },
    opts = { desc = 'Find files' },
    {
      { 'n' },
      function()
        if require('user.utils').is_inside_git_worktree() then
          require('telescope.builtin').git_files {}
        else
          require('telescope.builtin').find_files { hidden = true }
        end
      end,
    },
  },
  find_files = {
    keys = { '<leader>ff' },
    opts = { desc = 'Find files (ctrl-p)' },
    {
      { 'n' },
      function()
        require('telescope.builtin').find_files { hidden = true }
      end,
    },
  },
  find_git_files = {
    keys = { '<leader>fg' },
    opts = { desc = 'Find files, but only git-managed' },
    {
      { 'n' },
      function()
        require('telescope.builtin').git_files {}
      end,
    },
  },
  find_in_buffer = {
    keys = { '<leader>fb' },
    opts = { desc = 'Find in current buffer' },
    {
      { 'n' },
      function()
        require('telescope.builtin').current_buffer_fuzzy_find()
      end,
    },
  },
  find_help = {
    keys = { '<leader>fh' },
    opts = { desc = 'Find help page' },
    {
      { 'n' },
      function()
        require('telescope.builtin').help_tags()
      end,
    },
  },
  find_ctags = {
    keys = { '<leader>ft' },
    opts = { desc = 'Find ctags' },
    {
      { 'n' },
      function()
        require('telescope.builtin').tags()
      end,
    },
  },
  find_in_files = {
    keys = { '<leader>fp' },
    opts = { desc = 'Find in files (live grep)' },
    {
      { 'n' },
      function()
        require('telescope.builtin').live_grep()
      end,
    },
  },
  recent_files = {
    keys = { '<leader>f?' },
    opts = { desc = 'Recent files' },
    {
      { 'n' },
      function()
        require('telescope.builtin').oldfiles()
      end,
    },
  },
  resume_last = {
    keys = { '<leader>f.' },
    opts = { desc = 'Resume last' },
    {
      { 'n' },
      function()
        require('telescope.builtin').resume()
      end,
    },
  },
  find_diagnostics = {
    keys = { '<leader>fd' },
    opts = { desc = 'Find diagnostics' },
    {
      { 'n' },
      function()
        require('telescope.builtin').diagnostics()
      end,
    },
  },
}

M.setup = function()
  local config = {}
  config.extensions = {}
  config.defaults = {
    file_ignore_patterns = {
      [[^%.git/]],
      [[/%.git/]],
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

  -- Which-Key descriptions
  if pcall(require, 'which-key') then
    require('which-key').register {
      ['<leader>'] = {
        f = { name = 'Telescope...' },
      },
    }
  end

end

return M
