local M = {}

M.setup = function()
  require('dap').adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = 13000, -- 💀 Use the port printed out or specified with `--port`
  }

  require('dap').configurations.cpp = {
    {
      name = 'Launch file',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return ('%s/target/debug/aoc-2022-1'):format(vim.fn.getcwd())
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      runInTerminal = false,
    },
  }
  require('dap').configurations.c = require('dap').configurations.cpp
  require('dap').configurations.rust = require('dap').configurations.cpp

  vim.fn.sign_define(
    'DapBreakpoint',
    { text = '🛑', texthl = '', linehl = '', numhl = '' }
  )
end

return M
