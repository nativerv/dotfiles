--     _____   ____________   __    __  _____
--    /  _/ | / /  _/_  __/  / /   / / / /   |
--    / //  |/ // /  / /    / /   / / / / /| |
--  _/ // /|  // /  / /  _ / /___/ /_/ / ___ |
-- /___/_/ |_/___/ /_/  (_)_____/\____/_/  |_|
--
-- Description: A NeoVim configuration written in Lua
-- Author: nrv
-- URL: https://github.com/nativerv/dotfiles

-- Cache lua to improve startuptime - needs to be loaded as early as possible
pcall(require, 'impatient')

-- Bootstrap (download) `lazy.nvim` plugin manager
require 'user.bootstrap' 

-- Customize built-in nvim settings
require 'user.options' 

-- Customize built-in nvim mappings
require 'user.mappings' 

-- Autocmds that do different handy things, all still only using built-in nvim
-- stuff (no plugin stuff)
require 'user.autocmds' 

-- Install and configure plugins with `lazy.nvim`
require 'user.plugins' 
