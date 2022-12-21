local M = {}

M.setup = function()
  require('rest-nvim').setup {
    -- Open request results in a horizontal split
    result_split_horizontal = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = false,
    -- Highlight request on run
    highlight = {
      enabled = true,
      timeout = 150,
    },
    result = {
      -- toggle showing URL, HTTP info, headers at top the of result window
      show_url = true,
      show_http_info = true,
      show_headers = true,
    },
    -- Jump to request line on run
    jump_to_request = false,
    env_file = '.env',
    custom_dynamic_variables = {},
  }

  -- Keymaps
  -- Description
  if pcall(require, 'which-key') then
    require('which-key').register {
      ['<leader>'] = {
        t = {
          r = {
            name = 'rest.nvim...',
            r = { name = 'Run request' },
            p = { name = 'Preview' },
            l = { name = 'Run last request' },
          },
        },
      },
    }
  end
  -- Maps
  vim.keymap.set('n', '<leader>trr', require('rest-nvim').run)
  -- vim.keymap.set('n', '<leader>trp', require('rest-nvim').preview) -- seems that that got removed
  vim.keymap.set('n', '<leader>trl', require('rest-nvim').last) -- was run_last, now not even listed in the docs
end

return M
