-- Set a colorscheme. Fallback to one of default ones if colorscheme plugin is
-- not installed
if not pcall(vim.cmd.colorscheme, 'tokyonight') then
  vim.cmd.colorscheme 'habamax'
end

-- Send event (trigger my autocmds) (this is not always happening by default or
-- something for some reason)
vim.api.nvim_exec_autocmds({ 'ColorScheme' }, {})
