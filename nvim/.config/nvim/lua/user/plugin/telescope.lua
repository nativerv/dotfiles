local M = {}

M.setup = function()
  local config = {}
  config.extensions = {}
  config.defaults = {
    file_ignore_patterns = {
      '.git'
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
    require("telescope.themes").get_dropdown {
      -- even more opts
    }
  }

  -- Setup Telescope with the `config`
  require'telescope'.setup (config)

  -- Find files (Ctrl-P)
  vim.keymap.set('n', '<leader>ff', function () require"telescope.builtin".find_files({ hidden = true }) end)
  vim.keymap.set('n', '<C-p>',      function () require"telescope.builtin".find_files({ hidden = true }) end)
  -- The rest junk
  vim.keymap.set('n', '<leader>fb', function () require"telescope.builtin".current_buffer_fuzzy_find() end)
  vim.keymap.set('n', '<leader>fh', function () require"telescope.builtin".help_tags() end)
  vim.keymap.set('n', '<leader>ft', function () require"telescope.builtin".tags() end)
  vim.keymap.set('n', '<leader>fp', function () require"telescope.builtin".live_grep() end)
  vim.keymap.set('n', '<leader>?',  function () require"telescope.builtin".oldfiles() end)
  vim.keymap.set('n', '<leader>fd', function () require"telescope.builtin".diagnostics() end)
end

return M
