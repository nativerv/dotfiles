local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = '*/nvim/*.lua',
    group = vim.api.nvim_create_augroup(
      'nrv#packer_compile_config',
      { clear = true }
    ),
    callback = function()
      -- Transform string of form: 'lua/user/plugin/packer.lua' into 'user.plugin.packer'
      local module_path = vim.fn.expand '<afile>'
      -- local module_string = string.gsub(module_string, '/', '.')
      -- local module_string = string.gsub(module_string, '^lua.', '')
      -- local module_string = string.gsub(module_string, '.lua$', '')
      -- Require it (not workint atm for some reason, so i fell back to the :source method below)
      --require(module_string)
      vim.fn.system { "rm", vim.fn.stdpath 'config' .. '/plugin/packer_compiled.lua' }
      local command = ':source ' .. module_path
      vim.cmd(command)
      require('packer').compile()
    end,
  })
end


return M
