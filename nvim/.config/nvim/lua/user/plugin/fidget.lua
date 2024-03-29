local M = {}

M.setup = function()
  local left_margin = pcall(require, 'scrollview') and 3 or 0

  require('fidget').setup {
    text = {
      spinner = 'dots', -- animation shown when tasks are ongoing
      done = '✓', -- character shown when all tasks are complete
      commenced = 'Started', -- message shown when task starts
      completed = 'Completed', -- message shown when task completes
    },
    align = {
      bottom = true, -- align fidgets along bottom edge of buffer
      right = true, -- align fidgets along right edge of buffer
    },
    timer = {
      spinner_rate = 125, -- frame rate of spinner animation, in ms
      fidget_decay = 2000, -- how long to keep around empty fidget, in ms
      task_decay = 1000, -- how long to keep around completed task, in ms
    },
    window = {
      relative = 'win', -- where to anchor, either "win" or "editor"
      blend = 0, -- &winblend for the window
      zindex = 1, -- the zindex value for the window
      border = 'none', -- style of border for the fidget window
    },
    fmt = {
      leftpad = true, -- right-justify text in fidget box
      stack_upwards = true, -- list of tasks grows upwards
      max_width = 0, -- maximum width of the fidget box
      -- function to format fidget title
      fidget = function(fidget_name, spinner)
        return string.format(
          '[%s] %s%s',
          spinner,
          fidget_name,
          (' '):rep(left_margin)
        )
      end,
      -- function to format each task line
      task = function(task_name, message, percentage)
        return string.format(
          '%s%s [%s]%s',
          message,
          percentage and string.format(' (%s%%)', percentage) or '  ',
          task_name,
          (' '):rep(left_margin)
        )
      end,
    },
    -- sources = { -- Sources to configure
    --   ['*'] = { -- Name of source
    --     ignore = false, -- Ignore notifications from this source
    --   },
    -- },
    debug = {
      logging = false, -- whether to enable logging, for debugging
      strict = false, -- whether to interpret LSP strictly
    },
  }

  vim.api.nvim_set_hl(0, 'FidgetTitle', { link = 'FloatTitle' })
end

return M
