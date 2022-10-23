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

-- Preconfig
-- require 'user.utils'       -- Load util functions

-- Begin config
require 'user.bootstrap'   -- Ensure `packer.nvim` is installed - for new systems
require 'user.plugins'     -- Load plugins
require 'user.options'     -- Load options
require 'user.mappings'    -- Load keymaps
require 'user.autocmds'    -- Load autocommands
require 'user.colorscheme' -- Load colorscheme
require 'user.rc'          -- Load additional commands after everything else
