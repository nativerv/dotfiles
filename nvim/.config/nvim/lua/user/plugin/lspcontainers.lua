local M = {}

---@param server_name string
---@param opts table|nil
M.command = function(server_name, opts)
  opts = opts or {}
  local default_opts = {
    container_runtime = 'podman',
    root_dir = require('lspconfig/util').find_git_ancestor(),
  }
  opts = vim.tbl_extend('force', default_opts, opts)
  return require('lspcontainers').command(server_name, opts)
end

local function make_tsserver()
  local opts = {
    before_init = function(params)
      params.processId = vim.NIL
    end,
    cmd = M.command 'tsserver',
    root_dir = require('lspconfig/util').root_pattern(
      'package.json',
      'tsconfig.json',
      'jsconfig.json',
      '.git'
    ),
  }
  return opts
end

M.setup = function()
  -- Override or enable some lsps with lspcontainers
  local lspcontainers_configs = {
    -- bashls = {
    --   -- cmd = { 'bash-language-server', 'start' },
    --   filetypes = { 'sh', 'zsh' },
    --   before_init = function(params)
    --     params.processId = vim.NIL
    --   end,
    --   cmd = require('lspcontainers').command('bashls', {
    --     container_runtime = 'podman',
    --     root_dir = require('lspconfig/util').find_git_ancestor(),
    --   }),
    --   root_dir = require('lspconfig/util').find_git_ancestor,
    -- },
    tsserver = make_tsserver(),
  }

  -- Refresh (reconfigure) servers to include added new servers
  local lspconfig_config = require 'user.plugin.lspconfig'
  lspconfig_config.server_configs = vim.tbl_extend(
    'force',
    lspconfig_config.server_configs,
    lspcontainers_configs
  )
  require('user.plugin.lspconfig').configure_servers()
end

return M
