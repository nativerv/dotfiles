-- Set a colorscheme
local ok, _ = pcall(vim.cmd.colorscheme, 'tokyonight')

-- Fallback colorscheme if not installed
if not ok then
  vim.cmd.colorscheme 'habamax'
end

-- Send event (trigger my autocmds)
vim.api.nvim_exec_autocmds({ 'ColorScheme' }, {})
