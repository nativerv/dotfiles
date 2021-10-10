--     _____   ____________   __    __  _____
--    /  _/ | / /  _/_  __/  / /   / / / /   |
--    / //  |/ // /  / /    / /   / / / / /| |
--  _/ // /|  // /  / /  _ / /___/ /_/ / ___ |
-- /___/_/ |_/___/ /_/  (_)_____/\____/_/  |_|
--
-- | Description: A NeoVim configuration written in Lua
-- | Author: nrv
-- | URL: https://github.com/nativerv/dotfiles

-- | Preconfig
require 'utils'      -- | Load util functions

-- | Begin config
require 'bootstrap'  -- | Ensure `packer.nvim` is installed
require 'plugins'    -- | Load plugins
require 'options'    -- | Load options
require 'mappings'   -- | Load mappings
require 'rc'         -- | Load commands
