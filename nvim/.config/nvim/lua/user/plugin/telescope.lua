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

  -- To get ui-select loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require'telescope'.setup (config)
end

return M
