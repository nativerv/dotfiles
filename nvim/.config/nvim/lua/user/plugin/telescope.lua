return function ()
  require'telescope'.setup {
    defaults = {
      file_ignore_patterns = {
        '.git'
      },
      -- prompt_prefix = ' ',
      -- prompt_prefix = ' ',
      prompt_prefix = '  ',
    },
    pickers = {
      find_files = {
        hidden = true,
        --no_ignore = true,
      },
      live_grep = {
        hidden = true,
        --no_ignore = true,
      },
    }
  }
end

