local M = {}

local util = require 'user.utils'
local colors = require 'user.lib.colors'

local XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME'
  or (util.join_path { os.getenv 'HOME', '.cache' })
local wal_colors_module_path =
  util.join_path { XDG_CACHE_HOME, 'wal', 'colors.lua' }

local ok, wal_colors = pcall(dofile, wal_colors_module_path)
if not ok then
  vim.notify(
    ('lib/wal.lua: could not load colors.lua (path: "%s")'):format(
      wal_colors_module_path
    ),
    vim.log.levels.ERROR
  )
  return
end

M.colors = vim.tbl_map(function(color)
  return tonumber(color:gsub('^#', ''), 16)
end, wal_colors)
M.colors.lightened_1_background = colors.lighten(M.colors.background, 1.5)
M.colors.lightened_2_background = colors.lighten(M.colors.background, 2)
M.colors.lightened_3_background = colors.lighten(M.colors.background, 2.5)

return M
