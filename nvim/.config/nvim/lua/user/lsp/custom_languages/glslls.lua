local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

-- Check if it's already defined for when reloading this file.
if not lspconfig.glslls then
  configs.glslls = {
    default_config = {
      cmd = { 'glslls', '--stdin' };
      filetypes = { 'glsl' };
      root_dir = function(file_name)
        return lspconfig.util.find_git_ancestor(file_name) or vim.fn.expand('%:h') or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end
