-- | Author: nrv
-- | Description: pywal colorscheme

local mp = require'mp'
-- local utils = require'mp.utils'
-- local msg = require'mp.msg'

local xdg_cache_home = (os.getenv('XDG_CACHE_HOME') or (os.getenv('HOME') .. '/.cache'))
package.path = xdg_cache_home .. '/wal/?.lua;' .. package.path

local colors = require'colors'

mp.commandv('set', 'background', colors.background)
--mp.commandv('set', 'osd-back-color', colors.color1)
-- ^^^^ ~~~
-- TODO: implement OSC wal colors (seems like they're not exposed,
--       need to fork the source osc.lua file or something)
-- At least i have the BG color for now.
-- <https://github.com/mpv-player/mpv/blob/master/player/lua/osc.lua>
