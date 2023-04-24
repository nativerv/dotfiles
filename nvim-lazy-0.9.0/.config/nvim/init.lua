--     _____   ____________   __    __  _____
--    /  _/ | / /  _/_  __/  / /   / / / /   |
--    / //  |/ // /  / /    / /   / / / / /| |
--  _/ // /|  // /  / /  _ / /___/ /_/ / ___ |
-- /___/_/ |_/___/ /_/  (_)_____/\____/_/  |_|
--
-- Description: A NeoVim configuration written in Lua
-- Author: nrv
-- URL: https://github.com/nativerv/dotfiles

function yell(...)
  vim.notify(debug.traceback(...), vim.log.levels.TRACE)
  vim.notify(
    'Something went horribly wrong, most likely you broke something. Parts of your config will not work.', 
    vim.log.levels.WARN
  )
end

-- Bootstrap (download if not present) `lazy.nvim` plugin manager
xpcall(require, yell, 'user.bootstrap')

-- Customize built-in nvim settings
xpcall(require, yell, 'user.options')

-- Set mappings for built-in stuff
xpcall(require, yell, 'user.mappings')

-- Autocmds that do different handy things, all still only using built-in nvim
-- stuff 
xpcall(require, yell, 'user.autocmds')

-- Install and configure plugins with `lazy.nvim`, options, mappings and
-- autocmds for plugins all required from there
xpcall(require, yell, 'user.plugins')

-- Call my scratchpad ('Run Commands')
-- Stuff from there eventually belong in their separate place, like a custom plugin.
xpcall(require, yell, 'user.rc')

-- Colorscheme goes last
xpcall(require, yell, 'user.colorscheme')
