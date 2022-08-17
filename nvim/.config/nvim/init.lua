--     _____   ____________   __    __  _____
--    /  _/ | / /  _/_  __/  / /   / / / /   |
--    / //  |/ // /  / /    / /   / / / / /| |
--  _/ // /|  // /  / /  _ / /___/ /_/ / ___ |
-- /___/_/ |_/___/ /_/  (_)_____/\____/_/  |_|
--
-- | Description: A NeoVim configuration written in Lua
-- | Author: nrv
-- | URL: https://github.com/nativerv/dotfiles


-- | Cache lua - needs to be loaded as early as possible
pcall(require, 'impatient')

-- | Preconfig
require 'utils'       -- | Load util functions

-- | Begin config
require 'bootstrap'   -- | Ensure `packer.nvim` is installed - for new systems
require 'plugins'     -- | Load plugins
require 'options'     -- | Load options
require 'mappings'    -- | Load mappings
require 'autocmds'    -- | Load autocommands
require 'rc'          -- | Load commands & settings for various plugins
require 'colorscheme' -- | Load colorscheme
